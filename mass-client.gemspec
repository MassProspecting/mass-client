Gem::Specification.new do |s|
    s.name        = 'mass-client'
    s.version     = '1.0.1'
    s.date        = '2024-07-26'
    s.summary     = "Ruby library for Mass API."
    s.description = "Ruby library for Mass API."
    s.authors     = ["Leandro Daniel Sardi"]
    s.email       = 'leandro@massprospecting.com'
    s.files       = [
      'lib/mass-client.rb',
      'mass-client.gemspec'
    ]
    s.homepage    = 'https://github.com/massprospecting/mass-client'
    s.license     = 'MIT'
    s.add_runtime_dependency 'uri', '~> 0.11.2', '>= 0.11.2'
    s.add_runtime_dependency 'net-http', '~> 0.2.0', '>= 0.2.0'
    s.add_runtime_dependency 'json', '~> 2.6.3', '>= 2.6.3'
    s.add_runtime_dependency 'blackstack-core', '~> 1.2.15', '>= 1.2.15'
    #s.add_runtime_dependency 'selenium-webdriver', '~> 4.10.0', '>= 4.10.0'
    #s.add_runtime_dependency 'watir', '~> 7.3.0', '>= 7.3.0'
    s.add_runtime_dependency 'colorize', '~>0.8.1', '>= 0.8.1'
    s.add_runtime_dependency 'simple_cloud_logging', '~> 1.2.2', '>= 1.2.2'
    s.add_runtime_dependency 'simple_command_line_parser', '~> 1.1.2', '>= 1.1.2'
end