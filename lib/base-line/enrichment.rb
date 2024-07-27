module Mass
    class Enrichment < BlackStack::Base
        attr_accessor :type, :profile, :lead, :company, :profile_type

        def self.object_name
            'enrichment'
        end

        def initialize(h)
            super(h)
            self.type = Mass::EnrichmentType.new(h['enrichment_type_desc']) if h['enrichment_type_desc']
            self.profile = Mass::Profile.new(h['profile']).child_class_instance if h['profile']
            self.lead = Mass::Lead.new(h['lead']) if h['lead']
            self.company = Mass::Company.new(h['company']) if h['company']
            self.profile_type = Mass::ProfileType.page(
                page: 1,
                limit: 1,
                filters: {
                    name: h['profile_type']
                }
            ).first.child_class_instance if h['profile_type']
        end

        # convert the enrichment_type into the ruby class to create an instance.
        # example: Apollo --> Mass::ApolloAPI
        def class_name_from_enrichment_type
            enrichment_type = self.desc['enrichment_type']
            "Mass::#{enrichment_type}" 
        end

        # crate an instance of the profile type using the class defined in the `desc['name']` attribute.
        # override the base method
        def child_class_instance
            enrichment_type = self.desc['enrichment_type']
            key = self.class_name_from_enrichment_type
            raise "Source code of enrichment type #{enrichment_type} not found. Create a class #{key} in the folder `/lib` of your mass-sdk." unless Kernel.const_defined?(key)
            ret = Kernel.const_get(key).new(self.desc)
            return ret
        end

        # Update the lead or company with new information.
        #
        def do(
            logger:nil
        )
            # TODO: Code Me!
        end


    end # class Enrichment
end # module Mass