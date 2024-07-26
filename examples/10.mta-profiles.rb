# setup your MassProspecting API key to run these examples.
require 'lib/mass-client'
require 'config'
l = BlackStack::LocalLogger.new('./examples.log')

begin
    l.logs "Upserting profile types GMail... "
    Mass::ProfileType.upsert({
        'name' => 'GMail',
        'access' => :mta, # :rpa or :api or :mta or :none
        'channel' => :GMail, 
        # define default MTA parameters for the mta profile belonging to this type
        'default_smtp_address' => 'smtp.gmail.com',
        'default_smtp_port' => 25,
        'default_imap_port' => 993,	
        'default_imap_address' => 'imap.googlemail.com',
        'default_authentication' => :plain,
        'default_enable_starttls_auto' => true,
        'default_openssl_verify_mode' => :none,
        'default_inbox_label' => 'Inbox',
        'default_spam_label' => '[Gmail]/Spam',
        'default_search_all_wildcard' => '*', # '*' or 'ALL'
    })
    l.logf 'done'.green

    l.logs "Upserting profile types GMail... "
    Mass::ProfileType.upsert({
        'name' => 'Postmark',
        'access' => :mta, # :rpa or :api or :mta or :none
        'channel' => :Postmark, 
        # define default MTA parameters for the mta profile belonging to this type
        'default_smtp_address' => 'smtp.gmail.com',
        'default_smtp_port' => 25,
        'default_imap_port' => 993,	
        'default_imap_address' => 'imap.googlemail.com',
        'default_authentication' => :plain,
        'default_enable_starttls_auto' => true,
        'default_openssl_verify_mode' => :none,
        'default_inbox_label' => 'Inbox',
        'default_spam_label' => '[Gmail]/Spam',
        'default_search_all_wildcard' => '*', # '*' or 'ALL'
    })
    l.logf 'done'.green

    l.logs "Upserting profile Leandro @ GMail... "
    Mass::Profile.upsert({
        # Mandatory. A descriptive name of the profile.
        'name' => 'Leandro Sardi @ Gmail for Email Outreach',
        'picture_url' => 'https://media.licdn.com/dms/image/D4D03AQFKseTSZnpIAg/profile-displayphoto-shrink_100_100/0/1697551355295?e=1722470400&v=beta&t=2NZ4wUN2Cd9uzOuY0nrhWZOukpP84s3FPRFHNwOAZOs',
        # Mandatory. A type of the profile. 
        'profile_type' => :GMail,
        # Optional. Assign the profile to with for a specific `tag`. Default: nil.
        'tag' => :testing,
        # Mandatory.
        'hostname' => 'dev2',
        # Connection parameters for profiles 
        'smtp_username' => 'leandro.sardi@expandedventure.com',
        'smtp_password' => '**** **** **** ****',
        'imap_allowed' => true,
        'imap_username' => 'leandro.sardi@expandedventure.com',
        'imap_password' => '**** **** **** ****',
    })
    l.logf 'done'.green

    l.logs 'Loading list of objects... '
    n = Mass::ProfileType.count
    l.logf 'done'.green + " (#{n.to_s.blue} types)"

    l.logs 'Loading list of objects... '
    n = Mass::Profile.count
    l.logf 'done'.green + " (#{n.to_s.blue} profiles)"

rescue => e
    l.logf "Error: #{e.message}".red
end