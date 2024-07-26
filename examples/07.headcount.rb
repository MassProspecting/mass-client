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
    l.logs "Upserting '1 to 10 Employees' headcount... "
    Mass::Headcount.upsert({ 
        'name' => '1 to 10 Employees', 
        'channel' => :LinkedIn,
        'min' => 1,
        'max' => 10
    })
    l.logf 'done'.green

    l.logs "Upserting 'MassProspecting' company..."
    Mass::Company.upsert({
        'name' => 'MassProspecting',
        'domain' => 'https://massprospecting.com',
        'headcount' => '1 to 10 Employees',
    })
    l.logf 'done'.green

    l.logs 'Total... '
    n = Mass::Headcount.count
    l.logf 'done'.green + " (#{n.to_s.blue} headcounts)"
    
rescue => e
    l.logf "Error: #{e.to_console}".red
end