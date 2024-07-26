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
    l.logs "Upsert profile type Reoon... "
    Mass::ProfileType.upsert({
        'name' => 'Reoon',
        'channel' => :Reoon,
        'access' => :api, # :rpa or :api or :mta or :none

        # default quotas for enrichment automations
        # Use a negative value to disable the functionality        
        'default_enrichment_interval' => 1,
        'default_max_daily_processed_enrichments' => 5000,
        'default_max_daily_aborted_enrichments' => 5000,
    })
    l.logf 'done'.green

    l.logs "Upsert profile type ZeroBounce... "
    Mass::ProfileType.upsert({
        'name' => 'ZeroBounce',
        'channel' => :ZeroBounce,
        'access' => :api, # :rpa or :api or :mta or :none

        # default quotas for enrichment automations
        # Use a negative value to disable the functionality        
        'default_enrichment_interval' => 1,
        'default_max_daily_processed_enrichments' => 5000,
        'default_max_daily_aborted_enrichments' => 5000,
    })
    l.logf 'done'.green

    l.logs "Upsert profile type Targetron... "
    Mass::ProfileType.upsert({
        'name' => 'Targetron_API',
        'channel' => :Targetron,
        'access' => :api, # :rpa or :api or :mta or :none

        # default quotas for enrichment automations
        # Use a negative value to disable the functionality        
        'default_enrichment_interval' => 1,
        'default_max_daily_processed_enrichments' => 5000,
        'default_max_daily_aborted_enrichments' => 5000,
    })
    l.logf 'done'.green

    l.logs "Upsert profile type Apollo... "
    Mass::ProfileType.upsert({
        'name' => 'Apollo_API',
        'channel' => :Apollo,
        'access' => :api, # :rpa or :api or :mta or :none

        # default quotas for enrichment automations
        # Use a negative value to disable the functionality        
        'default_enrichment_interval' => 1,
        'default_max_daily_processed_enrichments' => 5000,
        'default_max_daily_aborted_enrichments' => 5000,
    })
    l.logf 'done'.green

    l.logs "Upsert profile type FindyMail... "
    Mass::ProfileType.upsert({
        'name' => 'FindyMail',
        'channel' => :FindyMail,
        'access' => :api, # :rpa or :api or :mta or :none

        # default quotas for enrichment automations
        # Use a negative value to disable the functionality        
        'default_enrichment_interval' => 1,
        'default_max_daily_processed_enrichments' => 5000,
        'default_max_daily_aborted_enrichments' => 5000,
    })
    l.logf 'done'.green

    l.logs "Upsert Leandro Sardi @ Reoon... "
    Mass::Profile.upsert({
        # Mandatory. A descriptive name of the profile.
        'name' => 'Leandro Sardi @ Reoon Email Verifier',
        'picture_url' => 'https://media.licdn.com/dms/image/D4D03AQFKseTSZnpIAg/profile-displayphoto-shrink_100_100/0/1697551355295?e=1722470400&v=beta&t=2NZ4wUN2Cd9uzOuY0nrhWZOukpP84s3FPRFHNwOAZOs',
        # Mandatory. A type of the profile. 
        'profile_type' => :'Reoon',
        # Mandatory if the `:access` attribute of the profile type is `:api`.
        'api_key' => 'xxxx',
        # Optional. Assign the profile to with for a specific `tag`. Default: nil.
        'tag' => :testing,
        # Mandatory. This is the node where the profile is running.
        'hostname' => 'dev2',

        # Use a negative value to disable the functionality        
        # Use the default values of the profile type if the attribute is not present.
        #
        #'enrichment_interval' => 1,
        #'max_daily_processed_enrichments' => 20,
        #'max_daily_aborted_enrichments' => 50,
    })
    l.logf 'done'.green

    l.logs "Upsert Leandro Sardi @ ZeroBounce... "
    Mass::Profile.upsert({
        # Mandatory. A descriptive name of the profile.
        'name' => 'Leandro Sardi @ ZeroBounce Email Verifier',
        'picture_url' => 'https://media.licdn.com/dms/image/D4D03AQFKseTSZnpIAg/profile-displayphoto-shrink_100_100/0/1697551355295?e=1722470400&v=beta&t=2NZ4wUN2Cd9uzOuY0nrhWZOukpP84s3FPRFHNwOAZOs',
        # Mandatory. A type of the profile. 
        'profile_type' => :'ZeroBounce',
        # Mandatory if the `:access` attribute of the profile type is `:api`.
        'api_key' => 'xxxx',
        # Optional. Assign the profile to with for a specific `tag`. Default: nil.
        'tag' => :testing,
        # Mandatory. This is the node where the profile is running.
        'hostname' => 'dev2',

        # Use a negative value to disable the functionality        
        # Use the default values of the profile type if the attribute is not present.
        #
        #'enrichment_interval' => 1,
        #'max_daily_processed_enrichments' => 20,
        #'max_daily_aborted_enrichments' => 50,
    })
    l.logf 'done'.green

    l.logs "Upsert Leandro Sardi @ Apollo... "
    Mass::Profile.upsert({
        # Mandatory. A descriptive name of the profile.
        'name' => 'Leandro Sardi @ Apollo for Email Appending',
        'picture_url' => 'https://media.licdn.com/dms/image/D4D03AQFKseTSZnpIAg/profile-displayphoto-shrink_100_100/0/1697551355295?e=1722470400&v=beta&t=2NZ4wUN2Cd9uzOuY0nrhWZOukpP84s3FPRFHNwOAZOs',
        # Mandatory. A type of the profile. 
        'profile_type' => :'Apollo_API',
        # Mandatory if the `:access` attribute of the profile type is `:api`.
        'api_key' => 'xxxx',
        # Optional. Assign the profile to with for a specific `tag`. Default: nil.
        'tag' => :testing,
        # Mandatory. This is the node where the profile is running.
        'hostname' => 'dev2',

        # Use a negative value to disable the functionality        
        # Use the default values of the profile type if the attribute is not present.
        #
        #'enrichment_interval' => 1,
        #'max_daily_processed_enrichments' => 20,
        #'max_daily_aborted_enrichments' => 50,
    })
    l.logf 'done'.green

    l.logs "Upsert Leandro Sardi @ FindyMail... "
    Mass::Profile.upsert({
        # Mandatory. A descriptive name of the profile.
        'name' => 'Leandro Sardi @ FindyMail for Email Appending',
        'picture_url' => 'https://media.licdn.com/dms/image/D4D03AQFKseTSZnpIAg/profile-displayphoto-shrink_100_100/0/1697551355295?e=1722470400&v=beta&t=2NZ4wUN2Cd9uzOuY0nrhWZOukpP84s3FPRFHNwOAZOs',
        # Mandatory. A type of the profile. 
        'profile_type' => :'FindyMail',
        # Mandatory if the `:access` attribute of the profile type is `:api`.
        'api_key' => 'xxxx',
        # Optional. Assign the profile to with for a specific `tag`. Default: nil.
        'tag' => :testing,
        # Mandatory. This is the node where the profile is running.
        'hostname' => 'dev2',

        # Use a negative value to disable the functionality        
        # Use the default values of the profile type if the attribute is not present.
        #
        #'enrichment_interval' => 1,
        #'max_daily_processed_enrichments' => 20,
        #'max_daily_aborted_enrichments' => 50,
    })
    l.logf 'done'.green

    l.logs 'Loading list of objects... '
    n = Mass::Channel.count
    l.logf 'done'.green + " (#{n.to_s.blue} channels)"

    l.logs 'Loading list of objects... '
    n = Mass::ProfileType.count
    l.logf 'done'.green + " (#{n.to_s.blue} types)"

    l.logs 'Loading list of objects... '
    n = Mass::Profile.count
    l.logf 'done'.green + " (#{n.to_s.blue} profiles)"

rescue => e
    l.logf "Error: #{e.message}".red
end