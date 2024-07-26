module Mass
    # Enrichment module.
    # List of methods you have to overload if you develop a profile type that supports enrichment operations.
    # 
    class EnrichmentType < BlackStack::Base
        def self.object_name
            'enrichment_type'
        end # def self.object_name

        # If the profile `access` is not `:rpa`, raise an exception.
        # Return `true` if the `url` is valid.
        # Return `false` if the `url` is not valid. 
        # 
        # Overload this method in the child class.
        # 
        def valid_enrichment_url?(url:)
            # If the profile `access` is not `:rpa`, raise an exception.
            raise "The method `valid_enrichment_url?` is not allowed for #{self.access.to_s} access." if self.access != :rpa
            # Return `true` if the `url` is valid.
            # Return `false` if the `url` is not valid. 
            true
        end # def valid_enrichment_url?

        # Return the same URL in a normalized form:
        # - remove all GET parameters.
        # - remove all trailing slashes.
        #
        # If the profile `access` is not `:rpa`, raise an exception.
        # If the `url` is not valid, raise an exception.
        # Return the normalized URL.
        # 
        # Overload this method in the child class.
        # 
        def normalized_enrichment_url(url:)
            # If the profile `access` is not `:rpa`, raise an exception.
            raise "The method `normalized_enrichment_url` is not allowed for #{self.access.to_s} access." if self.access != :rpa
            # Return the same URL in a normalized form:
            # - remove all GET parameters.
            # - remove all trailing slashes.
            url = url.gsub(/\?.*$/, '').strip
            url = ret.gsub(/\/+$/, '')
            # Return the normalized URL.
            url
        end # def normalized_enrichment_url

        # If the profile `access` is not `:api`, raise an exception.
        # Parameter `params` must be a hash.
        # Return `true` if the `params` are valid.
        # Return `false` if the `params` are not valid. 
        def valid_enrichment_params?(params:)
            # If the profile `access` is not `:api`, raise an exception.
            raise "The method `valid_enrichment_params?` is not allowed for #{self.access.to_s} access." if self.access != :api
            # Parameter `params` must be a hash.
            raise "The parameter `params` must be a hash." if !params.is_a?(Hash)
            # Return `true` if the `params` are valid.
            # Return `false` if the `params` are not valid. 
            true
        end # def valid_enrichment_params?
    end # class EnrichmentType
end # module Mass