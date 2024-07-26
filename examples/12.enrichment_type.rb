# setup your MassProspecting API key to run these examples.
require 'lib/mass-client'
require 'config'
l = BlackStack::LocalLogger.new('./examples.log')

begin
    # Verify Email with Reoon API
    # Verify Email with ZeroBounce API
    # Append Email with Apollo RPA
    # Append Email with Apollo API
    # Append Email with FindyMail API

    # Scrape LinkedIn company page, and its employees.
    # Scrape LinkedIn course, and its hosts and reviewers.
    # Scrape LinkedIn groups, and its owners/managers and members.
    # Scrape Facebook groups, and its owners/managers and members.


    l.logs "Submit Enrichment Type Reoon_EmailVerification... "
    et = Mass::EnrichmentType.upsert({
        # Mandatory. Name of the enrichment type.
        'name' => 'Reoon_EmailVerification',

        # Description of what does this enrichment type do.
        'description' => 'Use Reoon API to verify the email of a lead.',
    
        # Optional. Thunbnail of the RPA in action.
        'picture_url' => 'file://home/leandro/code/mass/extensions/mass.subaccount/public/mass.subaccount/images/enrichment-type/Apollo_LinkedInUrlToEmail.png',

        # Mandatory. What type of profile is required to run this enrichment.
        # Such a value must exists in the array of profiles hash descriptors.
        'profile_type' => :Reoon, 

        # Optional. If true, this scraping role is available for end-users to setup in the UI.
        # Default: true.
        'available' => true,        
    })
    l.logf 'done'.green + " (#{et.desc['name'].blue})"

    l.logs "Submit Enrichment Type ZeroBounce_EmailVerification... "
    et = Mass::EnrichmentType.upsert({
        # Mandatory. Name of the enrichment type.
        'name' => 'ZeroBounce_EmailVerification',

        # Description of what does this enrichment type do.
        'description' => 'Use ZeroBounce API to verify the email of a lead.',
    
        # Optional. Thunbnail of the RPA in action.
        'picture_url' => 'file://home/leandro/code/mass/extensions/mass.subaccount/public/mass.subaccount/images/enrichment-type/Apollo_LinkedInUrlToEmail.png',

        # Mandatory. What type of profile is required to run this enrichment.
        # Such a value must exists in the array of profiles hash descriptors.
        'profile_type' => :ZeroBounce, 

        # Optional. If true, this scraping role is available for end-users to setup in the UI.
        # Default: true.
        'available' => true,        
    })
    l.logf 'done'.green + " (#{et.desc['name'].blue})"

    l.logs "Submit Enrichment Type ApolloRPA_NameAndLinkedInUrlToEmail... "
    et = Mass::EnrichmentType.upsert({
        # Mandatory. Name of the enrichment type.
        'name' => 'ApolloRPA_NameAndLinkedInUrlToEmail',

        # Description of what does this enrichment type do.
        'description' => 'Using Apollo RPA for Getting the Email, Phone, Job Postion, Facebook and Company of a Lead from its LinkedIn URL, First Name and Last Name.
Search on Apollo by first name and last name, and iterate all the leads looking for one with the same LinkedIn URL.
Iterate up to 3 pages of Apollo results. 
If the LinkedIn URL is found, extract the email, phone, job position, facebook and company.',
    
        # Optional. Thunbnail of the RPA in action.
        'picture_url' => 'file://home/leandro/code/mass/extensions/mass.subaccount/public/mass.subaccount/images/enrichment-type/Apollo_LinkedInUrlToEmail.png',

        # Mandatory. What type of profile is required to run this enrichment.
        # Such a value must exists in the array of profiles hash descriptors.
        'profile_type' => :'Apollo_RPA', 

        # Optional. If true, this scraping role is available for end-users to setup in the UI.
        # Default: true.
        'available' => true,        
    })
    l.logf 'done'.green + " (#{et.desc['name'].blue})"

    l.logs "Submit Enrichment Type ApolloRPA_CompanyDomainToLeads... "
    et = Mass::EnrichmentType.upsert({
        # Mandatory. Name of the enrichment type.
        'name' => 'ApolloRPA_CompanyDomainToLeads',

        # Description of what does this enrichment type do.
        'description' => 'Using Apollo RPA for Getting the Email, Phone, Job Postion, Facebook and Company of al managers, directors, owners, founders, presidents and C-level people of a company.',
    
        # Optional. Thunbnail of the RPA in action.
        'picture_url' => 'file://home/leandro/code/mass/extensions/mass.subaccount/public/mass.subaccount/images/enrichment-type/Apollo_LinkedInUrlToEmail.png',

        # Mandatory. What type of profile is required to run this enrichment.
        # Such a value must exists in the array of profiles hash descriptors.
        'profile_type' => :'Apollo_RPA', 

        # Optional. If true, this scraping role is available for end-users to setup in the UI.
        # Default: true.
        'available' => true,

        # Allow user to setup one or more parameters (aka: on-the-fly filters).
        # Reference: https://github.com/MassProspecting/docs/issues/82
        'parameters' => "keyword",

        # Example: this is an example of all supported parameters
        #'parameters' => "email_verification_result;email;phone;linkedin;facebook;english_names_only;keyword;industry;headcount;revenue;country;sic;naics;location;",      
    })
    l.logf 'done'.green + " (#{et.desc['name'].blue})"

# -----------------------------------------------------------------------------------------------------------------------------------------------
# -----------------------------------------------------------------------------------------------------------------------------------------------
# The following enrichment types are still not available for end-users not available for end-users to setup in the UI.
# -----------------------------------------------------------------------------------------------------------------------------------------------
# -----------------------------------------------------------------------------------------------------------------------------------------------

    l.logs "Submit Enrichment Type FindyMailAPI_NameAndDomainToEmail... "
    et = Mass::EnrichmentType.upsert({
        # Mandatory. Name of the enrichment type.
        'name' => 'FindyMailAPI_NameAndDomainToEmail',

        # Description of what does this enrichment type do.
        'description' => 'Using FindyMail API for Getting the Email of a Lead from its LinkedIn URL.',
    
        # Optional. Thunbnail of the RPA in action.
        'picture_url' => 'file://home/leandro/code/mass/extensions/mass.subaccount/public/mass.subaccount/images/enrichment-type/Apollo_LinkedInUrlToEmail.png',

        # Mandatory. What type of profile is required to run this enrichment.
        # Such a value must exists in the array of profiles hash descriptors.
        'profile_type' => :'FindyMail', 

        # Optional. If true, this scraping role is available for end-users to setup in the UI.
        # Default: true.
        'available' => false,        
    })
    l.logf 'done'.green + " (#{et.desc['name'].blue})"
=begin
    l.logs "Submit Enrichment Type ApolloAPI_NameAndDomainToEmail... "
    et = Mass::EnrichmentType.upsert({
        # Mandatory. Name of the enrichment type.
        'name' => 'ApolloAPI_NameAndDomainToEmail',

        # Description of what does this enrichment type do.
        'description' => 'Using Apollo API for Getting the Email of a Lead from its name and company domain.',
    
        # Optional. Thunbnail of the RPA in action.
        'picture_url' => 'file://home/leandro/code/mass/extensions/mass.subaccount/public/mass.subaccount/images/enrichment-type/Apollo_LinkedInUrlToEmail.png',

        # Mandatory. What type of profile is required to run this enrichment.
        # Such a value must exists in the array of profiles hash descriptors.
        'profile_type' => :'Apollo_API', 

        # Optional. If true, this scraping role is available for end-users to setup in the UI.
        # Default: true.
        'available' => false,        
    })
    l.logf 'done'.green + " (#{et.desc['name'].blue})"


    l.logs "Submit Enrichment Type ApolloAPI_NameAndCompanyToEmail... "
    et = Mass::EnrichmentType.upsert({
        # Mandatory. Name of the enrichment type.
        'name' => 'ApolloAPI_NameAndCompanyToEmail',

        # Description of what does this enrichment type do.
        'description' => 'Using FindyMail API for Getting the Email of a Lead from its name and the name of the company.',
    
        # Optional. Thunbnail of the RPA in action.
        'picture_url' => 'file://home/leandro/code/mass/extensions/mass.subaccount/public/mass.subaccount/images/enrichment-type/Apollo_LinkedInUrlToEmail.png',

        # Mandatory. What type of profile is required to run this enrichment.
        # Such a value must exists in the array of profiles hash descriptors.
        'profile_type' => :'Apollo_API', 

        # Optional. If true, this scraping role is available for end-users to setup in the UI.
        # Default: true.
        'available' => false,        
    })
    l.logf 'done'.green + " (#{et.desc['name'].blue})"

    l.logs "Submit Enrichment Type ApolloAPI_JobTitleAndDomainToLead... "
    et = Mass::EnrichmentType.upsert({
        # Mandatory. Name of the enrichment type.
        'name' => 'ApolloAPI_JobTitleAndDomainToLead',

        # Description of what does this enrichment type do.
        'description' => 'Using FindyMail API for Getting leads with a specific job title and company domain.',
    
        # Optional. Thunbnail of the RPA in action.
        'picture_url' => 'file://home/leandro/code/mass/extensions/mass.subaccount/public/mass.subaccount/images/enrichment-type/Apollo_LinkedInUrlToEmail.png',

        # Mandatory. What type of profile is required to run this enrichment.
        # Such a value must exists in the array of profiles hash descriptors.
        'profile_type' => :'Apollo_API', 

        # Optional. If true, this scraping role is available for end-users to setup in the UI.
        # Default: true.
        'available' => false,        
    })
    l.logf 'done'.green + " (#{et.desc['name'].blue})"

    l.logs "Submit Enrichment Type LinkedInRPA_CoursesReview... "
    et = Mass::EnrichmentType.upsert({
        # Mandatory. Name of the enrichment type.
        'name' => 'LinkedInRPA_CoursesReview',

        # Description of what does this enrichment type do.
        'description' => 'Using LinkedIn RPA to scrape the leads who published a review in a LinkedIn Course.',
    
        # Optional. Thunbnail of the RPA in action.
        'picture_url' => 'file://home/leandro/code/mass/extensions/mass.subaccount/public/mass.subaccount/images/enrichment-type/linkedin-course-reviews.png',

        # Mandatory. What type of profile is required to run this enrichment.
        # Such a value must exists in the array of profiles hash descriptors.
        'profile_type' => :LinkedIn, 

        # Optional. If true, this scraping role is available for end-users to setup in the UI.
        # Default: true.
        'available' => false,        
    })
    l.logf 'done'.green + " (#{et.desc['name'].blue})"


    l.logs "Submit Enrichment Type LinkedInRPA_EventAttendees... "
    et = Mass::EnrichmentType.upsert({
        # Mandatory. Name of the enrichment type.
        'name' => 'LinkedInRPA_CoursesReview',

        # Description of what does this enrichment type do.
        'description' => 'Using LinkedIn RPA to scrape the leads who attended or are going to attend a LinkedIn Event.',
    
        # Optional. Thunbnail of the RPA in action.
        'picture_url' => 'file://home/leandro/code/mass/extensions/mass.subaccount/public/mass.subaccount/images/enrichment-type/linkedin-event-attendees.png',

        # Mandatory. What type of profile is required to run this enrichment.
        # Such a value must exists in the array of profiles hash descriptors.
        'profile_type' => :LinkedIn, 

        # Optional. If true, this scraping role is available for end-users to setup in the UI.
        # Default: true.
        'available' => false,        
    })
    l.logf 'done'.green + " (#{et.desc['name'].blue})"
=end

    l.logs 'Total... '
    n = Mass::EnrichmentType.count
    l.logf "done".green + " (#{n.to_s.blue} enrichment types)"

rescue => e
    l.logf "Error: #{e.message}".red
end