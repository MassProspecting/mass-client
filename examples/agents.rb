require_relative '../lib/mass-client'
require 'pry'

Mass.set(
    # mandatory parameters
    api_key: 'a59362ff-7a10-4d36-a4ad-e294b19c7e4c',
    subaccount: 'free-1',
    # connect to development environment
    api_url: 'http://127.0.0.1', 
    api_port: 3000,
    # optional parameters
    backtrace: true,
)

puts Mass::AIAgent.page(
    page: 1,
    limit: 100
).map { |o|
    o.desc
}
