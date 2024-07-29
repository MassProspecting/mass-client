require 'uri'
require 'net/http'
require 'json'
require 'blackstack-core'
require 'simple_cloud_logging'
require 'simple_command_line_parser'
require 'colorize'

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


