module Mass 
    class Profile < BlackStack::Base
        attr_accessor :type

        def self.object_name
            'profile'
        end

        def initialize(h)
            super(h)
            self.type = Mass::ProfileType.new(h['profile_type_desc']).child_class_instance
        end

        # convert the profile_type into the ruby class to create an instance.
        # example: Apollo --> Mass::ApolloAPI
        def class_name_from_profile_type
            profile_type = self.desc['profile_type']
            "Mass::#{profile_type}" 
        end

        # crate an instance of the profile type using the class defined in the `desc['name']` attribute.
        # override the base method
        def child_class_instance
            profile_type = self.desc['profile_type']
            key = self.class_name_from_profile_type
            raise "Source code of profile type #{profile_type} not found. Create a class #{key} in the folder `/lib` of your mass-sdk." unless Kernel.const_defined?(key)
            ret = Kernel.const_get(key).new(self.desc)
            return ret
        end
        
        # return true of the profile is running
        # if its profile type is rpa-access, then it will return true if the browser is running.
        # else, it will return always true.
        def running?
            if self.type.desc['access'].to_sym == :rpa
                c = AdsPowerClient.new(key: ADSPOWER_API_KEY)
                return c.check(self.desc['ads_power_id'])
            end
            return true
        end
        
        # Scrape the inbox of the profile.
        # Return a an array of hash descriptors of outreach records.
        # 
        # Parameters:
        # - limit: the maximum number of messages to scrape. Default: 100.
        # - only_unread: if true, then only the unread messages will be scraped. Default: true.
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
            []
        end # def inboxcheck

        # Scrape the inbox of the profile.
        # Return a an array of hash descriptors of outreach records.
        # 
        # Parameters:
        # - limit: the maximum number of connections to scrape. Default: 100.
        # - logger: a logger object to log the process. Default: nil.
        #
        # Example of a hash descritor into the returned array:
        # ```
        # {
        #    # a scraped message is always a :performed message
        #    'status' => :performed,
        #    # what is the outreach type?
        #    # e.g.: :LinkedIn_ConnectionRequest
        #    # decide this in the child class.
        #    'outreach_type' => nil,
        #    # hash descriptor of the profile who is scraping the inbox
        #    'profile' => self.desc,
        #    # hash descriptor of the lead who is the conversation partner
        #    'lead' => nil,
        #    # if the message has been sent by the profile, it is :outgoing.
        #    # if the message has been sent by the lead, it is :incoming.
        #    'direction' => :accepted, 
        # }
        # ```
        #
        def connectioncheck(limit: 100, logger:nil)
            []
        end # def inboxcheck

    end # class Profile
end # module Mass