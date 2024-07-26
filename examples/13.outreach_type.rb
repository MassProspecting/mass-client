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
    # LinkedIn Connection Request
    # LinkedIn Direct Message
    # Facebook Connection Request
    # Facebook Direct Message
    # GMail Direct Message
    
    l.logs "Submit Outreach Type LinkedIn_ConnectionRequest... "
    ot = Mass::OutreachType.upsert({
        # Mandatory. Name of the enrichment type.
        'name' => 'LinkedIn_ConnectionRequest',

        # Description of what does this enrichment type do.
        'description' => 'Send a LinkedIn connection request to a lead.',
    
        # Optional. Thunbnail of the RPA in action.
        'picture_url' => 'file://home/leandro/code/mass/extensions/mass.subaccount/public/mass.subaccount/images/outreach-type/linkedin-connection-request.png',

        # Mandatory. What type of profile is required to run this enrichment.
        # Such a value must exists in the array of profiles hash descriptors.
        'profile_type' => :LinkedIn, 

        # Optional. If true, this scraping role is available for end-users to setup in the UI.
        # Default: true.
        'available' => true,        
    })
    l.logf 'done'.green + " (#{ot.desc['name'].blue})"


    l.logs "Submit Outreach Type LinkedIn_DirectMessage... "
    ot = Mass::OutreachType.upsert({
        # Mandatory. Name of the enrichment type.
        'name' => 'LinkedIn_DirectMessage',

        # Description of what does this enrichment type do.
        'description' => 'Send a LinkedIn message to a lead who is a first degree connection of the assigned profile.',
    
        # Optional. Thunbnail of the RPA in action.
        'picture_url' => 'file://home/leandro/code/mass/extensions/mass.subaccount/public/mass.subaccount/images/outreach-type/linkedin-direct-message.png',

        # Mandatory. What type of profile is required to run this enrichment.
        # Such a value must exists in the array of profiles hash descriptors.
        'profile_type' => :LinkedIn, 

        # Optional. If true, this scraping role is available for end-users to setup in the UI.
        # Default: true.
        'available' => true,        
    })
    l.logf 'done'.green + " (#{ot.desc['name'].blue})"




    l.logs "Submit Outreach Type Facebook_FriendRequest... "
    ot = Mass::OutreachType.upsert({
        # Mandatory. Name of the enrichment type.
        'name' => 'Facebook_FriendRequest',

        # Description of what does this enrichment type do.
        'description' => 'Send a Facebook friend request to a lead.',
    
        # Optional. Thunbnail of the RPA in action.
        'picture_url' => 'file://home/leandro/code/mass/extensions/mass.subaccount/public/mass.subaccount/images/outreach-type/linkedin-connection-request.png',

        # Mandatory. What type of profile is required to run this enrichment.
        # Such a value must exists in the array of profiles hash descriptors.
        'profile_type' => :Facebook, 

        # Optional. If true, this scraping role is available for end-users to setup in the UI.
        # Default: true.
        'available' => true,        
    })
    l.logf 'done'.green + " (#{ot.desc['name'].blue})"


    l.logs "Submit Outreach Type Facebook_DirectMessage... "
    ot = Mass::OutreachType.upsert({
        # Mandatory. Name of the enrichment type.
        'name' => 'Facebook_DirectMessage',

        # Description of what does this enrichment type do.
        'description' => 'Send a Facebook message to a lead who can be already a friend of the assigned profile or not.',
    
        # Optional. Thunbnail of the RPA in action.
        'picture_url' => 'file://home/leandro/code/mass/extensions/mass.subaccount/public/mass.subaccount/images/outreach-type/linkedin-direct-message.png',

        # Mandatory. What type of profile is required to run this enrichment.
        # Such a value must exists in the array of profiles hash descriptors.
        'profile_type' => :Facebook, 

        # Optional. If true, this scraping role is available for end-users to setup in the UI.
        # Default: true.
        'available' => true,        
    })
    l.logf 'done'.green + " (#{ot.desc['name'].blue})"


    l.logs "Submit Outreach Type GMail_DirectMessage... "
    ot = Mass::OutreachType.upsert({
        # Mandatory. Name of the enrichment type.
        'name' => 'GMail_DirectMessage',

        # Description of what does this enrichment type do.
        'description' => 'Send an email to a lead.',
    
        # Optional. Thunbnail of the RPA in action.
        'picture_url' => 'file://home/leandro/code/mass/extensions/mass.subaccount/public/mass.subaccount/images/outreach-type/linkedin-direct-message.png',

        # Mandatory. What type of profile is required to run this enrichment.
        # Such a value must exists in the array of profiles hash descriptors.
        'profile_type' => :GMail, 

        # Optional. If true, this scraping role is available for end-users to setup in the UI.
        # Default: true.
        'available' => true,        
    })
    l.logf 'done'.green + " (#{ot.desc['name'].blue})"

    l.logs 'Total... '
    n = Mass::OutreachType.count
    l.logf "done".green + " (#{n.to_s.blue} outreach types)"

rescue => e
    l.logf "Error: #{e.message}".red
end