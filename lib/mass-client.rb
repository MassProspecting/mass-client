require 'uri'
require 'net/http'
require 'json'
require 'blackstack-core'
require 'simple_cloud_logging'
require 'simple_command_line_parser'
require 'colorize'

# base classes
require 'lib/base/channel'

require 'lib/base/profile_type'
require 'lib/base/source_type'
require 'lib/base/enrichment_type'
require 'lib/base/outreach_type'
require 'lib/base/data_type'

require 'lib/base/headcount'
require 'lib/base/industry'
require 'lib/base/location'
require 'lib/base/revenue'
require 'lib/base/tag'
require 'lib/base/profile'

require 'lib/base/source'
require 'lib/base/job'
require 'lib/base/event'

require 'lib/base/outreach'
require 'lib/base/enrichment'

require 'lib/base/company'
#require 'lib/base/company_data'
#require 'lib/base/company_industry'
#require 'lib/base/company_naics'
#require 'lib/base/company_sic'
#require 'lib/base/company_tag'

require 'lib/base/lead'
#require 'lib/base/lead_data'
#require 'lib/base/lead_tag'

require 'lib/base/inboxcheck'
require 'lib/base/connectioncheck'
require 'lib/base/rule'
require 'lib/base/request'

# first line of children
require 'lib/first/profile_api'
require 'lib/first/profile_mta'
require 'lib/first/profile_rpa'


