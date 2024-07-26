module Mass
    class Request < BlackStack::Base
        def self.object_name
          'request'
        end

        def perform(l)
          if self.desc['state'] == 'online'
            self.start_browser(l)
          elsif self.desc['state'] == 'idle'
            self.stop_browser(l)
          else
            raise "Unknown or unsupported request state: #{self.desc['state'].to_s}."
          end
        end
  
        def start_browser(l=nil)
          l = BlackStack::DummyLogger.new(nil) if l.nil?
          #raise "Profile is not waiting to start" if self.desc['profile']['state'].to_sym != :starting
          # start browser
          p = Mass::ProfileRPA.new(self.desc['profile'])
          p.driver
          # update profile state
          p.desc['state'] = :scraping_inbox
          p.upsert
        end
  
        def stop_browser(l=nil)
          l = BlackStack::DummyLogger.new(nil) if l.nil?
          #raise "Profile is not waiting to stop" if self.desc['profile']['state'].to_sym != :stopping
          c = AdsPowerClient.new(key: ADSPOWER_API_KEY)
          c.stop(self.desc['profile']['ads_power_id']) if c.check(self.desc['profile']['ads_power_id'])
          # get the profile for updating
          p = Mass::Profile.new(self.desc['profile'])
          p.desc['state'] = :idle
          p.upsert
        end

    end # class Request
end # module Mass
