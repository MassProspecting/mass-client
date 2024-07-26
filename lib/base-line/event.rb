module Mass
    class Event < BlackStack::Base
        attr_accessor :lead, :company

        def self.object_name
            'event'
        end

        def initialize(h)
            super(h)
            #self.lead = Mass::Lead.new(h['lead_desc']).child_class_instance if h['lead_desc']
            #self.company = Mass::Company.new(h['company_desc']).child_class_instance if h['company_desc']
        end
    end # class Event
end # module Mass