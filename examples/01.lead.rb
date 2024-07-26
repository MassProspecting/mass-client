# setup your MassProspecting API key to run these examples.
require 'lib/mass-client'
require 'config'
l = BlackStack::LocalLogger.new('./examples.log')

begin
    l.logs "Upsert Russell Brunson... "
    Mass::Lead.upsert({
        'first_name' => 'Russell',
        'last_name' => 'Brunson',
        'picture_url' => 'https://media.licdn.com/dms/image/C5603AQHltZ9o1QRiLA/profile-displayphoto-shrink_200_200/0/1606937713117?e=1723680000&v=beta&t=QXw9YtFnn8--ZI9qbPbLDImxfldUjj735tshBIjI_HM',
        'job_title' => 'Founder & CEO',
        'country' => 'United States',
        'timezone' => 'America/New_York',
        'facebook' => 'https://www.facebook.com/russbrunson',
        'linkedin' => 'https://www.linkedin.com/in/russellbrunson/?gg=rr',
        'tags' => ['testing'],
    })
    l.logf 'done'.green

    l.logs "Upsert Shaun Clark... "
    Mass::Lead.upsert({
        'first_name' => 'Shaun',
        'last_name' => 'Clark',
        'picture_url' => 'https://media.licdn.com/dms/image/D5603AQH--bwSFLPqAg/profile-displayphoto-shrink_200_200/0/1681238169996?e=1723680000&v=beta&t=RoUVXK2T9zVz3NcYtSjkJRQjAD_TZwMi9I1FMAbDjLY',
        'job_title' => 'Founder & CEO',
        'country' => 'United States',
        'timezone' => 'America/New_York',
        'facebook' => 'https://www.facebook.com/shaunclark869',
        'linkedin' => 'https://www.linkedin.com/in/shaunclarkhighlevel/',
        'tags' => ['testing'],
    })
    l.logf 'done'.green

    l.logs "Total... "
    arr = Mass::Lead.page(page:1, limit:10)
    l.logf "#{arr.count.to_s.blue}"            

rescue => e
    l.logf "Error: #{e.message}".red
end