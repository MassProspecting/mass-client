module Mass 
    # Base class.
    # List of methods you have to overload if you develop a profile type.
    # 
    class ProfileType < BlackStack::Base
        def self.object_name
            'profile_type'
        end
    end # class ProfileType
end # module Mass