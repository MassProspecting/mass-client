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
    l.logs "Upsert alternative_email... "
    Mass::DataType.upsert({
        'name' => 'alternative_email',
        'type' => :string,
        # validate the format of the values assigned
        'format' => '^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$',
    })
    l.logf 'done'.green

    l.logs "Upsert number_of_locations... "
    Mass::DataType.upsert({
        'name' => 'number_of_locations',
        'type' => :integer,
        # validate the range of the value on each data record.
        'min_integer' => 0,
        'max_integer' => 10000,
    })
    l.logf 'done'.green

    l.logs "Upsert market_capitalization... "
    Mass::DataType.upsert({
        'name' => 'market_capitalization',
        'type' => :float,
        # validate the range of the value on each data record.
        'min_float' => 0.0,
        'max_float' => (500*1000*1000*1000).to_f,
    })
    l.logf 'done'.green

    l.logs "Upsert Leandro Sardi... "
    Mass::Lead.upsert({
        'first_name' => 'Leandro',
        'email' => 'leandro@massprospecting.com',
        'data' => [
            {'type' => 'alternative_email', 'value' => 'leandro@vymeco.com'}
        ]
    })
    l.logf 'done'.green

    l.logs "Upsert MassProspecting... "
    Mass::Company.upsert({
        'name' => 'MassProspecting',
        'domain' => 'massprospecting.com',
        'data' => [
            {'type' => 'number_of_locations', 'value' => 5},
            {'type' => 'market_capitalization', 'value' => 1000000000.0} # $1B :)
        ]
    })
    l.logf 'done'.green

    l.logs 'Total... '
    n = Mass::DataType.count
    l.logf 'done'.green + " (#{n.to_s.blue} data types)"

rescue => e
    l.logf "Error: #{e.to_console}".red
end