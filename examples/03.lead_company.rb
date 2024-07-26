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
    l.logs "Upsert lead Leandro Sardi... "
    Mass::Lead.upsert({
        'first_name' => 'Leandro',
        'middle_name' => 'Daniel',
        'last_name' => 'Sardi',
        'picture_url' => 'https://media.licdn.com/dms/image/D4D03AQFKseTSZnpIAg/profile-displayphoto-shrink_200_200/0/1697551355295?e=1723680000&v=beta&t=QA4SnWhXdOy42m83NeVVBwTrfQk0JBK-1BjgDDGs6Cs',
        'email' => 'leandro@massprospecting.com',
        'linkedin' => 'https://www.linkedin.com/in/leandro-daniel-sardi/',
        'company' => {
            'name' => 'MassProspecting',
            'domain' => 'https://massprospecting.com',
        }
    })
    l.logf 'done'.green

    l.logs "Upsert company HighLevel... "
    Mass::Company.upsert({
        'name' => 'HighLevel',
        'domain' => 'https://www.gohighlevel.com/',
        'picture_url' => 'https://play-lh.googleusercontent.com/MAbanjWwLE2Ps3c6ZxUgLE6SMSzwy8PQ5mYvc_Txhn_1zv9gLEEKSsLYqW89y1wGdww=w240-h480-rw',
        'country' => 'United States',
        'timezone' => 'America/New_York',
        'tags' => ['testing'],  
        'leads' => [{
            'first_name' => 'Shaun',
            'last_name' => 'Clark',
            'picture_url' => 'https://media.licdn.com/dms/image/D5603AQH--bwSFLPqAg/profile-displayphoto-shrink_200_200/0/1681238169996?e=1723680000&v=beta&t=RoUVXK2T9zVz3NcYtSjkJRQjAD_TZwMi9I1FMAbDjLY',
            'job_title' => 'Founder & CEO',
            'country' => 'United States',
            'timezone' => 'America/New_York',
            'facebook' => 'https://www.facebook.com/shaunclark869',
            'linkedin' => 'https://www.linkedin.com/in/shaunclarkhighlevel/',
            'tags' => ['testing'],
        }],
    })
    l.logf 'done'.green

    l.logs 'Total... '
    n = Mass::Lead.count
    l.logf 'done'.green + " (#{n.to_s.blue} leads)"

    l.logs 'Total... '
    n = Mass::Company.count
    l.logf 'done'.green + " (#{n.to_s.blue} companies)"

rescue => e
    l.logf "Error: #{e.message}".red
end