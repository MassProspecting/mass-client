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
    l.logs "Upserting 'Internet' industry... "
    Mass::Industry.upsert({ 
        'name' => 'Internet', 
        'channel' => :LinkedIn,
    })
    l.logf 'done'.green

    l.logs "Upserting 'MassProspecting' company..."
    Mass::Company.upsert({
        'name' => 'MassProspecting',
        'domain' => 'https://massprospecting.com',
        'industry' => ['Internet'],
    })
    l.logf 'done'.green

    l.logs 'Total... '
    n = Mass::Industry.count
    l.logf 'done'.green + " (#{n.to_s.blue} industries)"
    
rescue => e
    l.logf "Error: #{e.to_console}".red
end