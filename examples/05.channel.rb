# setup your MassProspecting API key to run these examples.
require 'lib/mass-client'
require 'config'
l = BlackStack::LocalLogger.new('./examples.log')

begin
    l.logs "Upsert LinkedIn... "
    Mass::Channel.upsert({ 
        'name' => 'LinkedIn', 
        'avatar_url' => 'file://./images/channel/linkedin.png', 
        'color_code' => :light_blue 
    })
    l.logf 'done'.green

    l.logs "Upsert Facebook... "
    Mass::Channel.upsert({
        'name' => 'Facebook',
        'avatar_url' => 'file://../image/channel/facebook.png',
        'color_code' => :blue
    })
    l.logf 'done'.green

    l.logs "Upsert Apollo... "
    Mass::Channel.upsert({
        'name' => 'Apollo',
        'avatar_url' => 'file://../image/channel/apollo.png',
        'color_code' => :yellow
    })
    l.logf 'done'.green

    l.logs "Upsert Indeed... "
    Mass::Channel.upsert({
        'name' => 'Indeed',
        'avatar_url' => 'file://../image/channel/indeed.png',
        'color_code' => :yellow
    })
    l.logf 'done'.green

    l.logs "Upsert FindyMail... "
    Mass::Channel.upsert({
        'name' => 'FindyMail',
        'avatar_url' => 'file://../image/channel/findymail.png',
        'color_code' => :red
    })
    l.logf 'done'.green

    l.logs "Upsert Targetron... "
    Mass::Channel.upsert({
        'name' => 'Targetron',
        'avatar_url' => 'file://../image/channel/targetron.png',
        'color_code' => :black
    })
    l.logf 'done'.green

    l.logs "Upsert Reoon... "
    Mass::Channel.upsert({
        'name' => 'Reoon',
        'avatar_url' => 'file://../image/channel/reoon.png',
        'color_code' => :red
    })
    l.logf 'done'.green

    l.logs "Upsert ZeroBounce... "
    Mass::Channel.upsert({
        'name' => 'ZeroBounce',
        'avatar_url' => 'file://../image/channel/zerobounce.png',
        'color_code' => :yellow
    })
    l.logf 'done'.green

    l.logs "Upsert GMail... "
    Mass::Channel.upsert({
        'name' => 'GMail',
        'avatar_url' => 'file://../image/channel/gmail.png',
        'color_code' => :red
    })
    l.logf 'done'.green

    l.logs "Upsert Postmark... "
    Mass::Channel.upsert({
        'name' => 'Postmark',
        'avatar_url' => 'file://../image/channel/postmark.png',
        'color_code' => :yellow
    })
    l.logf 'done'.green

    l.logs 'Total... '
    n = Mass::Channel.count
    l.logf 'done'.green + " (#{n.to_s.blue} channels)"


rescue => e
    l.logf "Error: #{e.to_console}".red
end