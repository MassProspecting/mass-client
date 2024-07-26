# setup your MassProspecting API key to run these examples.

# Use the following script to clear all enrichments done and start testing again:
=begin
update lead set email_verification_result=null where email_verification_result is not null;
update lead set email=null where email is not null;
delete from enrichment_screenshot;
delete from enrichment_snapshot;
delete from enrichment;
=end

require 'mysaas'
require 'lib/stubs'
require 'config'
require 'version'

require 'extensions/mass.subaccount/lib/stubs'
require 'extensions/mass.subaccount/main'

BlackStack::Extensions.append :'mass.subaccount'

l = BlackStack::LocalLogger.new('./examples.log')

begin
    l.logs "Loading leads... "
    leads = Mass::Lead.page(
        page: 1,
        limit: 10
    )
    l.logf 'done'.green + " (#{leads.size.to_s.blue} leads)"

    leads.each { |lead|
        l.logs "Verify lead #{lead.desc['first_name'].blue} #{lead.desc['last_name'].blue}... "
        if lead.desc['email'].nil? || lead.desc['email'].to_s.empty?
            l.logf 'skipped'.yellow + " (no email)"
        elsif !lead.desc['email_verification_result'].nil?
            l.logf 'skipped'.yellow + " (email already verified)"
        else
            # creating an enrichment job
            e = Mass::Enrichment.page(
                page: 1,
                limit: 1,
                filters: {
                    'id_lead' => lead.desc['id'],
                    'enrichment_type' => :'Reoon_EmailVerification',
                    'status' => :pending
                }
            ).first
            unless e
                e = Mass::Enrichment.insert({
                    'enrichment_type' => :'Reoon_EmailVerification',
                    'lead' => lead.desc,
                    'status' => :pending,
                    'tag' => :testing,
                })
            end

            # run the enrichment job
            if e.profile.nil?
                l.logf 'skipped'.yellow + " (no profile assigned - run /p/plan.rb first)"
            else
                e.do(logger:l)
                l.logf 'done'.green

                l.logs "Update lead #{lead.desc['first_name'].blue} #{lead.desc['last_name'].blue}... "
                e.lead.update
                l.logf 'done'.green

                l.logs "Update enrichment #{e.desc['id'].blue}... "
                e.desc['status'] = :performed
                e.update
                l.logf 'done'.green
            end
        end
    }
rescue => e
    l.logf "Error: #{e.message}".red
end