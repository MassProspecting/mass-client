module Mass
    class Outreach < BlackStack::Base
        attr_accessor :type, :profile, :lead, :company, :profile_type

        def self.object_name
            'outreach'
        end

        def initialize(h)
            super(h)
            self.type = Mass::OutreachType.new(h['outreach_type_desc']) if h['outreach_type_desc']
            self.profile = Mass::Profile.new(h['profile']).child_class_instance if h['profile']
            self.lead = Mass::Lead.new(h['lead']) if h['lead']
            self.company = Mass::Company.new(h['company']) if h['company']
            self.profile_type = Mass::ProfileType.page(
                id_account: h['id_account'],
                page: 1,
                limit: 1,
                filters: {
                    name: h['profile_type']
                }
            ).first.child_class_instance if h['profile_type']
        end

        # convert the outreach_type into the ruby class to create an instance.
        # example: Apollo --> Mass::ApolloAPI
        def class_name_from_outreach_type
            outreach_type = self.desc['outreach_type']
            "Mass::#{outreach_type}" 
        end

        # crate an instance of the profile type using the class defined in the `desc['name']` attribute.
        # override the base method
        def child_class_instance
binding.pry
            outreach_type = self.desc['outreach_type']
            key = self.class_name_from_outreach_type
            raise "Source code of outreach type #{outreach_type} not found. Create a class #{key} in the folder `/lib` of your mass-sdk." unless Kernel.const_defined?(key)
            ret = Kernel.const_get(key).new(self.desc)
            return ret
        end

    end # class Outreach
end # module Mass