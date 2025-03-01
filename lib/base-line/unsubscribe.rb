module Mass
    class Unsubscribe < BlackStack::Base
        #attr_accessor :type, :profile, :lead, :company, :profile_type

        def self.object_name
            'unsubscribe'
        end

        def initialize(h)
            super(h)
            self.id_outreach = h['profile_type'] if h['profile_type']
        end
    end # class Unsubscribe
end # module Mass