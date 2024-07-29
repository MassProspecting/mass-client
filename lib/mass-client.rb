require 'uri'
require 'net/http'
require 'json'
require 'blackstack-core'
require 'simple_cloud_logging'
require 'simple_command_line_parser'
require 'colorize'

# base classes
require_relative './lib/base-line/channel'

require_relative './lib/base-line/profile_type'
require_relative './lib/base-line/source_type'
require_relative './lib/base-line/enrichment_type'
require_relative './lib/base-line/outreach_type'
require_relative './lib/base-line/data_type'

require_relative './lib/base-line/headcount'
require_relative './lib/base-line/industry'
require_relative './lib/base-line/location'
require_relative './lib/base-line/revenue'
require_relative './lib/base-line/tag'
require_relative './lib/base-line/profile'

require_relative './lib/base-line/source'
require_relative './lib/base-line/job'
require_relative './lib/base-line/event'

require_relative './lib/base-line/outreach'
require_relative './lib/base-line/enrichment'

require_relative './lib/base-line/company'
#require_relative './lib/base-line/company_data'
#require_relative './lib/base-line/company_industry'
#require_relative './lib/base-line/company_naics'
#require_relative './lib/base-line/company_sic'
#require_relative './lib/base-line/company_tag'

require_relative './lib/base-line/lead'
#require_relative './lib/base-line/lead_data'
#require_relative './lib/base-line/lead_tag'

require_relative './lib/base-line/inboxcheck'
require_relative './lib/base-line/connectioncheck'
require_relative './lib/base-line/rule'
require_relative './lib/base-line/request'

# first line of children
require_relative './lib/first-line/profile_api'
require_relative './lib/first-line/profile_mta'
require_relative './lib/first-line/profile_rpa'


