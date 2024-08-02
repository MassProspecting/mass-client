require 'uri'
require 'net/http'
require 'json'
require 'blackstack-core'
require 'simple_cloud_logging'
require 'simple_command_line_parser'
require 'colorize'

# mass client configuration
module Mass
    @@js_path
    @@drownload_path

    def self.set(js_path:, download_path:)
        # validate: download_path must be a string or an arrow of strings
        if download_path.is_a?(String)
            raise ArgumentError.new("The parameter 'download_path' must be a string or an array of strings.") if download_path.to_s.empty?
        elsif download_path.is_a?(Array)
            download_path.each { |p|
                raise ArgumentError.new("The parameter 'download_path' must be a string or an array of strings.") if p.to_s.empty?
            }
        else
            raise ArgumentError.new("The parameter 'download_path' must be a string or an array of strings.")
        end

        @@js_path = js_path
        @@download_path = download_path
    end

    def self.download_path
        @@download_path
    end

    def self.js_path
        @@js_path
    end
end # module Mass

# base classes
require_relative './/base-line/channel'

require_relative './/base-line/profile_type'
require_relative './/base-line/source_type'
require_relative './/base-line/enrichment_type'
require_relative './/base-line/outreach_type'
require_relative './/base-line/data_type'

require_relative './/base-line/headcount'
require_relative './/base-line/industry'
require_relative './/base-line/location'
require_relative './/base-line/revenue'
require_relative './/base-line/tag'
require_relative './/base-line/profile'

require_relative './/base-line/source'
require_relative './/base-line/job'
require_relative './/base-line/event'

require_relative './/base-line/outreach'
require_relative './/base-line/enrichment'

require_relative './/base-line/unsubscribe'

require_relative './/base-line/company'
#require_relative './/base-line/company_data'
#require_relative './/base-line/company_industry'
#require_relative './/base-line/company_naics'
#require_relative './/base-line/company_sic'
#require_relative './/base-line/company_tag'

require_relative './/base-line/lead'
#require_relative './/base-line/lead_data'
#require_relative './/base-line/lead_tag'

require_relative './/base-line/inboxcheck'
require_relative './/base-line/connectioncheck'
require_relative './/base-line/rule'
require_relative './/base-line/request'

# first line of children
require_relative './/first-line/profile_api'
require_relative './/first-line/profile_mta'
require_relative './/first-line/profile_rpa'


