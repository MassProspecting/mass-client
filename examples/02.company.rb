# setup your MassProspecting API key to run these examples.
require 'lib/mass-client'
require 'config'
l = BlackStack::LocalLogger.new('./examples.log')

begin
    l.logs "Upsert MassProspecting... "
    Mass::Company.upsert({
        'name' => 'MassProspecting',
        'domain' => 'https://massprospecting.com',
        'picture_url' => "file://./favicon.png",
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