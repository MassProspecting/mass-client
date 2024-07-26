# setup your MassProspecting API key to run these examples.
require 'mysaas'
require 'lib/stubs'
require 'config'
require 'version'

require 'extensions/mass.subaccount/lib/stubs'
require 'extensions/mass.subaccount/main'

BlackStack::Extensions.append :'mass.subaccount'

l = BlackStack::LocalLogger.new('./examples.log')

begin
    l.logs "Upserting 'From $1M to $10M per Year' revenue... "
    Mass::Revenue.upsert({ 
        'name' => 'From $1M to $10M per Year', 
        'channel' => :LinkedIn,
        'min' => 1000000,
        'max' => 10000000
    })
    l.logf 'done'.green

    l.logs "Upserting 'MassProspecting' company..."
    Mass::Company.upsert({
        'name' => 'MassProspecting',
        'domain' => 'https://massprospecting.com',
        'revenue' => 'From $1M to $10M per Year',
    })
    l.logf 'done'.green

    l.logs 'Total... '
    n = Mass::Revenue.count
    l.logf 'done'.green + " (#{n.to_s.blue} objects)"
    
rescue => e
    l.logf "Error: #{e.to_console}".red
end