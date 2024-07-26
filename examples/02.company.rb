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
    l.logs "Upsert MassProspecting... "
    Mass::Company.upsert({
        'name' => 'MassProspecting',
        'domain' => 'https://massprospecting.com',
        'picture_url' => "file://home/leandro/code/mass/extensions/mass.subaccount/public/mass.subaccount/images/favicon.png",
        'country' => 'Uruguay',
        'timezone' => 'America/Argentina/Buenos_Aires',
        'tags' => ['testing'],  
        'sic' => ['9995', 100],
        'naics' => [112120, '1111A0'],
    })
    l.logf 'done'.green

    l.logs "Total... "
    arr = Mass::Company.page(page:1, limit:10)
    l.logf "#{arr.count.to_s.blue}"            

rescue => e
    l.logf "Error: #{e.message}".red
end