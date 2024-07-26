# setup your MassProspecting API key to run these examples.
require 'lib/mass-client'
require 'config'
l = BlackStack::LocalLogger.new('./examples.log')

begin
    l.logs "Upserting profile type LinkedIn... "
    Mass::ProfileType.upsert({
        'name' => 'LinkedIn',
        'access' => :rpa, # :rpa or :api or :mta or :none
        'channel' => :LinkedIn,
    })
    l.logf 'done'.green

    l.logs "Upserting profile type Facebook... "
    Mass::ProfileType.upsert({
        'name' => 'Facebook',
        'access' => :rpa, # :rpa or :api or :mta or :none
        'channel' => :Facebook,
        'allow_intercept_js' => true,
    })
    l.logf 'done'.green

    l.logs "Upserting profile type Targetron... "
    Mass::ProfileType.upsert({
        'name' => 'Targetron_RPA',
        'access' => :rpa, # :rpa or :api or :mta or :none
        'channel' => :Targetron,
    })
    l.logf 'done'.green

    l.logs "Upserting profile type Apollo... "
    Mass::ProfileType.upsert({
        'name' => 'Apollo_RPA',
        'access' => :rpa, # :rpa or :api or :mta or :none
        'channel' => :Apollo,
    })
    l.logf 'done'.green

    l.logs "Upserting profile type Indeed... "
    Mass::ProfileType.upsert({
        'name' => 'Indeed',
        'access' => :basic, # :rpa or :api or :mta or :none
        'channel' => :Indeed,
    })
    l.logf 'done'.green

    l.logs "Upserting profile Leandro Sardi @ LinkedIn... "
    p = Mass::Profile.upsert({
        # Mandatory. A descriptive name of the profile.
        'name' => 'Leandro Sardi @ LinkedIn for Scraping & Social Media Outreach',
        'picture_url' => 'https://media.licdn.com/dms/image/D4D03AQFKseTSZnpIAg/profile-displayphoto-shrink_100_100/0/1697551355295?e=1722470400&v=beta&t=2NZ4wUN2Cd9uzOuY0nrhWZOukpP84s3FPRFHNwOAZOs',
        # Mandatory. A type of the profile. 
        'profile_type' => :LinkedIn,
        # Optional. Assign the profile to with for a specific `tag`. Default: nil.
        'tag' => :testing,
        # Mandatory.
        'hostname' => 'dev2',
        # Connection parameters for profiles 
        'ads_power_id' => 'jilvc0o',
        'state' => :idle,
    })
    l.logf 'done'.green

    l.logs "Upserting profile Leandro Sardi @ Facebook... "
    Mass::Profile.upsert({
        # Mandatory. A descriptive name of the profile.
        'name' => 'Leandro Sardi @ Facebook for Scraping & Social Media Outreach',
        'picture_url' => 'https://media.licdn.com/dms/image/D4D03AQFKseTSZnpIAg/profile-displayphoto-shrink_100_100/0/1697551355295?e=1722470400&v=beta&t=2NZ4wUN2Cd9uzOuY0nrhWZOukpP84s3FPRFHNwOAZOs',
        # Mandatory. A type of the profile. 
        'profile_type' => :Facebook,
        # Optional. Assign the profile to with for a specific `tag`. Default: nil.
        'tag' => :testing,
        # Mandatory.
        'hostname' => 'dev2',
        # Connection parameters for profiles 
        'ads_power_id' => 'jiv7rw7',
        'state' => :idle,
    })
    l.logf 'done'.green

    l.logs "Upserting profile Leandro Sardi @ Apollo... "
    Mass::Profile.upsert({
        # Mandatory. A descriptive name of the profile.
        'name' => 'Leandro Sardi @ Apollo for Scraping & Enrichment',
        'picture_url' => 'https://media.licdn.com/dms/image/D4D03AQFKseTSZnpIAg/profile-displayphoto-shrink_100_100/0/1697551355295?e=1722470400&v=beta&t=2NZ4wUN2Cd9uzOuY0nrhWZOukpP84s3FPRFHNwOAZOs',
        # Mandatory. A type of the profile. 
        'profile_type' => :'Apollo_RPA',
        # Optional. Assign the profile to with for a specific `tag`. Default: nil.
        'tag' => :testing,
        # Mandatory.
        'hostname' => 'dev2',
        # Connection parameters for profiles 
        'ads_power_id' => 'jh5o4dt',
        'state' => :idle,
    })
    l.logf 'done'.green

    l.logs "Upserting request... "
    r = Mass::Request.upsert({
        'id_profile' => p.desc['id'],
        'state' => :online,
    })
    l.logf 'done'.green

    l.logs 'Loading list of objects... '
    n = Mass::ProfileType.count
    l.logf 'done'.green + " (#{n.to_s.blue} types)"

    l.logs 'Loading list of objects... '
    n = Mass::Profile.count
    l.logf 'done'.green + " (#{n.to_s.blue} profiles)"

    l.logs 'Loading list of objects... '
    n = Mass::Request.count
    l.logf 'done'.green + " (#{n.to_s.blue} requests)"

rescue => e
    l.logf "Error: #{e.message}".red
end