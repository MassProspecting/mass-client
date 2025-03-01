module Mass
    class SourceType < BlackStack::Base
        # NEVER EVER DOWNLOAD LINKEDIN/FACEBOOK IMAGES USING THE LOCAL IP ADDRESS.
        # USE THE SAME BROWSER DRIVER AND JAVASCRIPT INSTEAD OF THE LOCAL IP ADDRESS.
        #extend BlackStack::Storage # include the module with the class methods

        attr_accessor :profile_type

        def initialize(h={})
            super(h)
            self.profile_type = Mass::ProfileType.page(
                id_account: h['id_account'],
                page: 1,
                limit: 1,
                filters: {
                    name: h['profile_type']
                }
            ).first.child_class_instance if h['profile_type']
        end

        def self.object_name
            'source_type'
        end
    end # class SourceType
end # module Mass