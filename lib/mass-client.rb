require 'uri'
require 'net/http'
require 'json'
require 'blackstack-core'
require 'simple_cloud_logging'
require 'simple_command_line_parser'
require 'colorize'

# base classes
require 'lib/base-line/channel'

require 'lib/base-line/profile_type'
require 'lib/base-line/source_type'
require 'lib/base-line/enrichment_type'
require 'lib/base-line/outreach_type'
require 'lib/base-line/data_type'

require 'lib/base-line/headcount'
require 'lib/base-line/industry'
require 'lib/base-line/location'
require 'lib/base-line/revenue'
require 'lib/base-line/tag'
require 'lib/base-line/profile'

require 'lib/base-line/source'
require 'lib/base-line/job'
require 'lib/base-line/event'

require 'lib/base-line/outreach'
require 'lib/base-line/enrichment'

require 'lib/base-line/company'
#require 'lib/base-line/company_data'
#require 'lib/base-line/company_industry'
#require 'lib/base-line/company_naics'
#require 'lib/base-line/company_sic'
#require 'lib/base-line/company_tag'

require 'lib/base-line/lead'
#require 'lib/base-line/lead_data'
#require 'lib/base-line/lead_tag'

require 'lib/base-line/inboxcheck'
require 'lib/base-line/connectioncheck'
require 'lib/base-line/rule'
require 'lib/base-line/request'

# first line of children
require 'lib/first-line/profile_api'
require 'lib/first-line/profile_mta'
require 'lib/first-line/profile_rpa'


