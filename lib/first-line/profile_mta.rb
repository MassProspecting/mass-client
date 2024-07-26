module Mass
    class ProfileMTA < Mass::Profile

        # Scrape the inbox of the profile.
        # Return a an array of hash descriptors of outreach records.
        # 
        # Parameters:
        # - limit: the maximum number of messages to scrape. Default: 100.
        # - only_unread: if true, then only the unread messages will be scraped. This parameter is not used by :mta profiles. Default: true.
        # - logger: a logger object to log the process. Default: nil.
        #
        # Example of a hash descritor into the returned array:
        # ```
        # {
        #    # a scraped message is always a :performed message
        #    'status' => :performed,
        #    # what is the outreach type?
        #    # e.g.: :LinkedIn_DirectMessage
        #    # decide this in the child class.
        #    'outreach_type' => nil,
        #    # hash descriptor of the profile who is scraping the inbox
        #    'profile' => self.desc,
        #    # hash descriptor of the lead who is the conversation partner
        #    'lead' => nil,
        #    # if the message has been sent by the profile, it is :outgoing.
        #    # if the message has been sent by the lead, it is :incoming.
        #    'direction' => nil, 
        #    # the content of the message
        #    'subject' => nil,
        #    'body' => nil,
        # }
        # ```
        #
        def inboxcheck(limit: 100, only_unread:true, logger:nil)
            l = logger || BlackStack::DummyLogger.new(nil)
            ret = []
            p = self
            t = self.type
            sources = [
                {:folder=>p.desc['inbox_label'] || t.desc['default_inbox_label'], :track_field=>'imap_inbox_last_id'}, 
                #{:folder=>p.desc['spam_label'] || t.desc['default_inbox_label'], :track_field=>'imap_spam_last_id'},
            ]

            # connecting imap 
            l.logs "Connecting IMAP... "
            imap = Net::IMAP.new(
                p.desc['imap_address'] || t.desc['default_imap_address'], 
                p.desc['imap_port'] || t.desc['default_imap_port'], 
                true
            )
            conn = imap.login(
                p.desc['imap_username'], 
                p.desc['imap_password']
            )
            l.logf "done (#{conn.name})"

            sources.each { |source|
                folder = source[:folder]
                track_field = source[:track_field]

                l.logs "Choosing mailbox #{folder}... "
                    l.logs "Examine folder... "
                    res = imap.examine(folder)
                    l.logf "done (#{res.name})"
            
                    # Gettin latest `limit` messages received, in descendent order (newer first), 
                    # in order to stop when I find the latest procesed before.
                    l.logs "Getting latest #{limit.to_s} messages... "
                    ids = imap.search(["SUBJECT", p.desc['search_all_wildcard']]).reverse[0..limit]
                    l.logf "done (#{ids.size.to_s} messages)"

                    # iterate the messages
                    last_message_id = nil
                    ids.each { |id|
                        l.logs "Processing message #{id.to_s.blue}... "
                        # getting the envelope
                        envelope = imap.fetch(id, "ENVELOPE")[0].attr["ENVELOPE"]

                        # TODO: develop a normalization function for mail.message_id
                        message_id = envelope.message_id.to_s.gsub(/^</, '').gsub(/>$/, '')
                        
                        # if this is the first message, then remember it
                        last_message_id = message_id if last_message_id.nil?

                        # check if this message_id is the latest processed
                        if message_id == p.desc[track_field]
                            l.logf "skip".yellow + " (already processed)"
                            break
                        #elsif envelope.subject =~ /[0-9A-Z]{7}\-[0-9A-Z]{7}/i
                        #    l.logf "Instantly warming email".red
                        else
                            lead_email = envelope.from[0].mailbox.to_s + '@' + envelope.from[0].host.to_s
                            lead_name = envelope.from[0].name
                            subject = envelope.subject
                            body = imap.fetch(id, "BODY[]")[0].attr["BODY[]"]
                            
                            # analyzing bounce reports
                            #rep = Sisimai.make(body)
                            #is_bounce = !rep.nil?
                            #bounce_reason = rep[0].reason if rep
                            #bounce_diagnosticcode = rep[0].diagnosticcode if rep
            
                            h = {
                                # a scraped message is always a :performed message
                                'status' => :performed,
                                # what is the outreach type?
                                # e.g.: :LinkedIn_DirectMessage
                                # decide this in the child class.
                                'outreach_type' => :GMail_DirectMessage,
                                # hash descriptor of the profile who is scraping the inbox
                                'profile' => p.desc,
                                # hash descriptor of the lead who is the conversation partner
                                'lead_or_company' => {
                                  'name' => lead_name,
                                  'email' => lead_email,
                                },
                                # if the message has been sent by the profile, it is :outgoing.
                                # if the message has been sent by the lead, it is :incoming.
                                'direction' => :incoming, 
                                # the content of the message
                                'subject' => subject,
                                'body' => body,
                            }
                            ret << h

                            l.logf "done".green
                        end                        
                    }
                    
                    # remember the latest message_id processed
                    p.desc[track_field] = last_message_id if last_message_id

                l.done

            } # end folders.each

            # disconnect
            l.logs "Disconnecting IMAP... "
            res = imap.logout
            l.logf "done (#{res.name})"

            # return
            return ret
        end # def inboxcheck
        
    end # class ProfileMTA
end # module Mass
