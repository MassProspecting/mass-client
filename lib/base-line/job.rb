module Mass
    class Job < BlackStack::Base
        attr_accessor :profile, :source

        def self.object_name
            'job'
        end

        def initialize(h)
            super(h)
            self.profile = Mass::Profile.new(h['profile']).child_class_instance if h['profile']
            self.source = Mass::Source.new(h['source_desc']).child_class_instance if h['source_desc']
        end

        # Submit a hash descriptor to the server for an upsert.
        # Optimizaton: remove the events from the job descriptor, and submit events one by one.
        def upsert
            job = self
            events = job.desc['events'].dup
            job.desc['events'] = []
            
            # cap the number of events to job.desc['max_events']
            events = events[0..job.desc['max_events']-1] if job.desc['max_events'] && events.size > job.desc['max_events']

            # initialize the id_account and id_job for each event
            events.each { |e| 
                e['id_account'] = job.desc['id_account']
                e['id_job'] = job.desc['id'] 
            }

            # upsert the events
            events = events.map { |e| Mass::Event.new(e) }
            super()
            #k = 0
            #puts
            events.each { |e| 
                #k += 1
                #print "k: #{k}... "
                res = e.upsert 
                #puts res.nil? ? "nil" : res.desc['id']
            }

            job.desc['events'] = events.map { |e| e.desc } # setup the events array into the job again
        end

        def do(logger:nil)
            self.source.do(
                job: self,
                logger: logger,
            )
        end

        # return true if the assigned profile can download multiple files (allow_browser_to_download_multiple_files)
        # and the source can download pictures (download_pictures)
        def can_download_images?
            self.profile.desc['allow_browser_to_download_multiple_files'] && self.source.desc['download_pictures']
        end

    end # class Job
end # module Mass