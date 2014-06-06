Gem::Specification.new do |s|
  s.name = %q(meez)
  s.version = '0.2.5'
  s.date = %q(2014-01-08)
  s.summary = 'Initializes a chef cookbook with TDD framework'
  s.description = <<EOF
`Meez` (slang for `mise en place`) will create an opinionated chef cookbook skeleton complete with testing suite including:
    berkshelf, chefspec, test kitchen, foodcritic, server spec

EOF
  s.files = %x(git ls-files).split("\n")

  s.executables = ['meez']
  s.authors = ['Paul Czarkowski']
  s.email   = 'paul.czarkowski@rackspace.com'
  s.homepage = 'http://github.com/paulczar/meez'
  s.license = 'apache2'
  s.require_paths = ['lib']
  s.add_dependency 'chef', '~> 11.8'
  s.add_dependency 'test-kitchen', '~> 1.2'
  s.add_dependency 'bundler', '~> 1.5'
  s.add_dependency 'berkshelf', '~> 3.1'
end
