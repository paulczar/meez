Gem::Specification.new do |s|
  s.name = %q{meez}
  s.version = '0.0.4'
  s.date = %q{2014-01-08}
  s.summary = 'Initializes a chef cookbook with TDD framework'
  s.description = <<EOF
`Meez` (slang for `mise en place`) will create an opinionated chef cookbook skeleton complete with testing suite including:
    berkshelf, chefspec, test kitchen, strainer, foodcritic, server spec

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
  s.add_dependency 'berkshelf', '~> 2.0.12'
end
