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
    # Scrape Leads from Apollo
    # Scrape Leads from LinkedIn Public Feed
    # Scrape Leads from Facebook Public Feed
    # Scrape Leads from Facebook Group Posts

    # Scrape LinkedIn companies
    # Scrape Companies from LinkedIn Jobs Board
    # Scrape Companies from Indeed Jobs Board
    # Scrape LinkedIn events, and register them as communities
    # Scrape LinkedIn courses, and register them as communities
    # Scrape LinkedIn groups, and register them as communities
    # Scrape Facebook groups, and register them as communities

    
    l.logs "Submit Source Type Apollo_PeopleSearch... "
    et = Mass::SourceType.upsert({
        # Mandatory. Name of the source type.
        'name' => 'Apollo_PeopleSearch',

        # Description of what does this source type do.
        'description' => 'Run an Apollo search using RPA to reduce your cost by 10X; and grab their email, company, and linkedin URL.',
    
        # Optional. Thunbnail of the RPA in action.
        'picture_url' => 'file://home/leandro/code/mass/extensions/mass.subaccount/public/mass.subaccount/images/source-types/apollo-people-search.png',

        # Mandatory. What type of profile is required to run this source.
        # Such a value must exists in the array of profiles hash descriptors.
        'profile_type' => :Apollo_RPA, 

        # Optional. If true, this scraping role is available for end-users to setup in the UI.
        # Default: true.
        'available' => true,     
        
        # Optional. Events per page.
        # Default: 10.
        'default_event_limit' => 25,

        # Optional. URL pattern to match the URL of the source.
        'url_pattern' => 'https://app.apollo.io/#/people',

        # 
        'paginable' => true,
        
    })
    l.logf 'done'.green + " (#{et.desc['name'].blue})"

    l.logs "Submit Source Type Targetron_LocalBusinesses... "
    et = Mass::SourceType.upsert({
        # Mandatory. Name of the source type.
        'name' => 'Targetron_LocalBusinesses',

        # Description of what does this source type do.
        'description' => 'Run an Targetron search using RPA to unlone all its filters; and grab local businesses\' email, address, reviews, website and phone number.',
    
        # Optional. Thunbnail of the RPA in action.
        'picture_url' => 'file://home/leandro/code/mass/extensions/mass.subaccount/public/mass.subaccount/images/source-types/targetron-local-business-search.png',

        # Mandatory. What type of profile is required to run this source.
        # Such a value must exists in the array of profiles hash descriptors.
        'profile_type' => :Targetron_RPA, 

        # Optional. If true, this scraping role is available for end-users to setup in the UI.
        # Default: true.
        'available' => true,     
        
        # Optional. Events per page.
        # Default: 10.
        'default_event_limit' => 25,
    })
    l.logf 'done'.green + " (#{et.desc['name'].blue})"
=begin
    l.logs "Submit Source Type Targetron_LocalBusinesses... "
    et = Mass::SourceType.upsert({
        # Mandatory. Name of the source type.
        'name' => 'Targetron_PeopleSearch',

        # Description of what does this source type do.
        'description' => 'Run an Targetron search using RPA to unlone all its filters; and grab local businesses\' email, address, reviews, website and phone number.',
    
        # Optional. Thunbnail of the RPA in action.
        'picture_url' => 'file://home/leandro/code/mass/extensions/mass.subaccount/public/mass.subaccount/images/source-types/targetron-local-business-search.png',

        # Mandatory. What type of profile is required to run this source.
        # Such a value must exists in the array of profiles hash descriptors.
        'profile_type' => :Targetron_API, 

        # Optional. If true, this scraping role is available for end-users to setup in the UI.
        # Default: true.
        'available' => true,     
        
        # Optional. Events per page.
        # Default: 10.
        'default_event_limit' => 25,
    })
    l.logf 'done'.green + " (#{et.desc['name'].blue})"
=end
    l.logs "Submit Source Type LinkedIn_PublicFeed... "
    et = Mass::SourceType.upsert({
        # Mandatory. Name of the source type.
        'name' => 'LinkedIn_PublicFeed',

        # Description of what does this source type do.
        'description' => 'Scrape posts from the public feed of LinkedIn using RPA, and grab the leads who posted, the content of the posts and the images in the posts.',
    
        # Optional. Thunbnail of the RPA in action.
        'picture_url' => 'file://home/leandro/code/mass/extensions/mass.subaccount/public/mass.subaccount/images/source-types/linkedin-public-feed.png',

        # Mandatory. What type of profile is required to run this source.
        # Such a value must exists in the array of profiles hash descriptors.
        'profile_type' => :LinkedIn, 

        # Optional. If true, this scraping role is available for end-users to setup in the UI.
        # Default: true.
        'available' => true,     
        
        # Optional. URL pattern to match the URL of the source.
        'url_pattern' => 'https://www.linkedin.com/search/results/content'
    })
    l.logf 'done'.green + " (#{et.desc['name'].blue})"

    l.logs "Submit Source Type Facebook_GroupPosts... "
    et = Mass::SourceType.upsert({
        # Mandatory. Name of the source type.
        'name' => 'Facebook_GroupPosts',

        # Description of what does this source type do.
        'description' => 'Scrape latest posts on all the Facebook groups where your Profiles are members, and grab the leads who posted, the content and the images in the posts.',
    
        # Optional. Thunbnail of the RPA in action.
        'picture_url' => 'file://home/leandro/code/mass/extensions/mass.subaccount/public/mass.subaccount/images/source-types/facebook-group-posts.png',

        # Mandatory. What type of profile is required to run this source.
        # Such a value must exists in the array of profiles hash descriptors.
        'profile_type' => :Facebook, 

        # Optional. If true, this scraping role is available for end-users to setup in the UI.
        # Default: true.
        'available' => true,        

        # Optional. URL pattern to match the URL of the source.
        'url_pattern' => 'https://www.facebook.com/?filter=groups&sk=h_chr',
    })
    l.logf 'done'.green + " (#{et.desc['name'].blue})"

# -----------------------------------------------------------------------------------------------------------------------------------------------
# -----------------------------------------------------------------------------------------------------------------------------------------------
# The following source types are still not available for end-users not available for end-users to setup in the UI.
# -----------------------------------------------------------------------------------------------------------------------------------------------
# -----------------------------------------------------------------------------------------------------------------------------------------------

    l.logs "Submit Source Type Facebook_PublicFeed... "
    et = Mass::SourceType.upsert({
        # Mandatory. Name of the source type.
        'name' => 'Facebook_PublicFeed',

        # Description of what does this source type do.
        'description' => 'Scrape posts in the public feed of Facebook using RPA, and grab the leads who posted, the content and the images in the posts.',
    
        # Optional. Thunbnail of the RPA in action.
        'picture_url' => 'file://home/leandro/code/mass/extensions/mass.subaccount/public/mass.subaccount/images/source-types/facebook-public-feed.png',

        # Mandatory. What type of profile is required to run this source.
        # Such a value must exists in the array of profiles hash descriptors.
        'profile_type' => :Facebook, 

        # Optional. If true, this scraping role is available for end-users to setup in the UI.
        # Default: true.
        'available' => true,        
    })
    l.logf 'done'.green + " (#{et.desc['name'].blue})"
=begin
    l.logs "Submit Source Type Facebook_GroupsFeed... "
    et = Mass::SourceType.upsert({
        # Mandatory. Name of the source type.
        'name' => 'Facebook_GroupsFeed',

        # Description of what does this source type do.
        'description' => 'Scrape posts on Facebook groups where your Profiles are members, and grab the leads who posted, the content and the images in the posts.',
    
        # Optional. Thunbnail of the RPA in action.
        'picture_url' => 'file://home/leandro/code/mass/extensions/mass.subaccount/public/mass.subaccount/images/source-types/facebook-group-posts.png',

        # Mandatory. What type of profile is required to run this source.
        # Such a value must exists in the array of profiles hash descriptors.
        'profile_type' => :Facebook, 

        # Optional. If true, this scraping role is available for end-users to setup in the UI.
        # Default: true.
        'available' => false,        
    })
    l.logf 'done'.green + " (#{et.desc['name'].blue})"
=end
    l.logs "Submit Source Type LinkedIn_Companies... "
    et = Mass::SourceType.upsert({
        # Mandatory. Name of the source type.
        'name' => 'LinkedIn_Companies',

        # Description of what does this source type do.
        'description' => 'Run a companies search using LinkedIn RPA.',
    
        # Optional. Thunbnail of the RPA in action.
        'picture_url' => 'file://home/leandro/code/mass/extensions/mass.subaccount/public/mass.subaccount/images/source-types/linkedin-companies.png',

        # Mandatory. What type of profile is required to run this source.
        # Such a value must exists in the array of profiles hash descriptors.
        'profile_type' => :LinkedIn, 

        # Optional. If true, this scraping role is available for end-users to setup in the UI.
        # Default: true.
        'available' => false,        
    })
    l.logf 'done'.green + " (#{et.desc['name'].blue})"


    l.logs "Submit Source Type LinkedIn_Jobs... "
    et = Mass::SourceType.upsert({
        # Mandatory. Name of the source type.
        'name' => 'LinkedIn_Jobs',

        # Description of what does this source type do.
        'description' => 'Run a job-openings search using LinkedIn RPA.',
    
        # Optional. Thunbnail of the RPA in action.
        'picture_url' => 'file://home/leandro/code/mass/extensions/mass.subaccount/public/mass.subaccount/images/source-types/linkedin-jobs.png',

        # Mandatory. What type of profile is required to run this source.
        # Such a value must exists in the array of profiles hash descriptors.
        'profile_type' => :LinkedIn, 

        # Optional. If true, this scraping role is available for end-users to setup in the UI.
        # Default: true.
        'available' => false,        
    })
    l.logf 'done'.green + " (#{et.desc['name'].blue})"


    l.logs "Submit Source Type Indeed_Jobs... "
    et = Mass::SourceType.upsert({
        # Mandatory. Name of the source type.
        'name' => 'Indeed_Jobs',

        # Description of what does this source type do.
        'description' => 'Run a job-openings search using Indeed RPA.',
    
        # Optional. Thunbnail of the RPA in action.
        'picture_url' => 'file://home/leandro/code/mass/extensions/mass.subaccount/public/mass.subaccount/images/source-types/indeed-jobs.png',

        # Mandatory. What type of profile is required to run this source.
        # Such a value must exists in the array of profiles hash descriptors.
        'profile_type' => :Indeed, 

        # Optional. If true, this scraping role is available for end-users to setup in the UI.
        # Default: true.
        'available' => true,        
    })
    l.logf 'done'.green + " (#{et.desc['name'].blue})"


    l.logs "Submit Source Type LinkedIn_Events... "
    et = Mass::SourceType.upsert({
        # Mandatory. Name of the source type.
        'name' => 'LinkedIn_Events',

        # Description of what does this source type do.
        'description' => 'Run an events search using LinkedIn RPA.',
    
        # Optional. Thunbnail of the RPA in action.
        'picture_url' => 'file://home/leandro/code/mass/extensions/mass.subaccount/public/mass.subaccount/images/source-types/linkedin-events.png',

        # Mandatory. What type of profile is required to run this source.
        # Such a value must exists in the array of profiles hash descriptors.
        'profile_type' => :LinkedIn, 

        # Optional. If true, this scraping role is available for end-users to setup in the UI.
        # Default: true.
        'available' => false,        
    })
    l.logf 'done'.green + " (#{et.desc['name'].blue})"


    l.logs "Submit Source Type LinkedIn_Courses... "
    et = Mass::SourceType.upsert({
        # Mandatory. Name of the source type.
        'name' => 'LinkedIn_Courses',

        # Description of what does this source type do.
        'description' => 'Run a courses search using LinkedIn RPA.',
    
        # Optional. Thunbnail of the RPA in action.
        'picture_url' => 'file://home/leandro/code/mass/extensions/mass.subaccount/public/mass.subaccount/images/source-types/linkedin-courses.png',

        # Mandatory. What type of profile is required to run this source.
        # Such a value must exists in the array of profiles hash descriptors.
        'profile_type' => :LinkedIn, 

        # Optional. If true, this scraping role is available for end-users to setup in the UI.
        # Default: true.
        'available' => false,        
    })
    l.logf 'done'.green + " (#{et.desc['name'].blue})"


    l.logs "Submit Source Type LinkedIn_Groups... "
    et = Mass::SourceType.upsert({
        # Mandatory. Name of the source type.
        'name' => 'LinkedIn_Groups',

        # Description of what does this source type do.
        'description' => 'Run a groups search using LinkedIn RPA.',
    
        # Optional. Thunbnail of the RPA in action.
        'picture_url' => 'file://home/leandro/code/mass/extensions/mass.subaccount/public/mass.subaccount/images/source-types/linkedin-groups.png',

        # Mandatory. What type of profile is required to run this source.
        # Such a value must exists in the array of profiles hash descriptors.
        'profile_type' => :LinkedIn, 

        # Optional. If true, this scraping role is available for end-users to setup in the UI.
        # Default: true.
        'available' => false,        
    })
    l.logf 'done'.green + " (#{et.desc['name'].blue})"


    l.logs "Submit Source Type Facebook_Groups... "
    et = Mass::SourceType.upsert({
        # Mandatory. Name of the source type.
        'name' => 'Facebook_Groups',

        # Description of what does this source type do.
        'description' => 'Run a groups search using Facebook RPA.',
    
        # Optional. Thunbnail of the RPA in action.
        'picture_url' => 'file://home/leandro/code/mass/extensions/mass.subaccount/public/mass.subaccount/images/source-types/facebook-groups.png',

        # Mandatory. What type of profile is required to run this source.
        # Such a value must exists in the array of profiles hash descriptors.
        'profile_type' => :LinkedIn, 

        # Optional. If true, this scraping role is available for end-users to setup in the UI.
        # Default: true.
        'available' => false,        
    })
    l.logf 'done'.green + " (#{et.desc['name'].blue})"


    l.logs 'Total... '
    n = Mass::SourceType.count
    l.logf "done".green + " (#{n.to_s.blue} source types)"

rescue => e
    l.logf "Error: #{e.to_console}".red
end