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
    l.logs "Upsert 'testing'... "
    Mass::Tag.upsert({ 
        'name' => 'testing', 
        'color_code' => :green
    })
    l.logf 'done'.green

    l.logs "Upsert 'tag1'... "
    Mass::Tag.upsert({ 
        'name' => 'tag1', 
        'color_code' => :blue
    })
    l.logf 'done'.green

    l.logs "Upsert 'tag2'... "
    Mass::Tag.upsert({ 
        'name' => 'tag2', 
        'color_code' => :red
    })
    l.logf 'done'.green

    l.logs "Total... "
    arr = Mass::Tag.page(page:1, limit:10)
    l.logf "#{arr.count.to_s.blue} tags"            

rescue => e
    l.logf "Error: #{e.to_console}".red
end