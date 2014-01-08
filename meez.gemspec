Gem::Specification.new do |s|
  s.name = %q{meez}
  s.version = '0.0.1'
  s.date = %q{2014-01-07}
  s.summary = 'initializes chef cookbook with TDD framework'
  s.description = <<EOF
berkshelf + chefspec + test kitchen + strainer + foodcritic + server spec
EOF
  s.files = [
    'lib/meez/meez.rb'
  ]
  s.executables = [
    'meez'
  ]
  s.authors = ['Paul Czarkowski']
  s.email   = 'paul.czarkowski@rackspace.com'
  s.homepage = 'http://github.com/paulczar/meez'
  s.license = 'apache2'
  s.require_paths = ['lib']
  s.add_dependency 'chef', '~> 11.8.0'
  s.add_dependency 'test-kitchen', '~> 1.1.1'
  s.add_dependency 'bundler', '~> 1.5.1'
end
