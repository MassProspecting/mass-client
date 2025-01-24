module Mass
    class ConnectionCheck < BlackStack::Base
        attr_accessor :profile

        def self.object_name
            'connectioncheck'
        end

        def initialize(h)
            super(h)
            self.profile = Mass::Profile.get(h['id_profile']).child_class_instance if h['id_profile']
        end
    end # class ConnectionCheck
end # module Mass