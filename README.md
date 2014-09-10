Meez
----

About
=====

`Meez` is slang for `mise en place`

`Mise en place` is a French phrase which means "putting in place", as in set up. It is used in professional kitchens to refer to organizing and arranging the ingredients (e.g., cuts of meat, relishes, sauces, par-cooked items, spices, freshly chopped vegetables, and other components) that a cook will require for the menu items that he or she expects to prepare during his/her shift.[1] The practice is also effective in home kitchens.

`Meez` will create an opinionated chef cookbook skeleton complete with testing suite.

Install
=======

Setting the environment variable `USE_SYSTEM_GECODE=1` will help speed up builds by using the system `gecode` rather than compiling it from scratch.

You may need to install `gecode` on your system: http://www.gecode.org/download.html

for OSX I did

```
$ cd $( brew --prefix )
$ git checkout 3c5ca25 Library/Formula/gecode.rb
$ brew install gecode
$ brew link gecode
```

Official
----------

as of version `0.2.0` this is offered as a `chefdk` plugin.

`chef gem install meez`


Usage
=====

```
Usage: meez [options] <cookbook name>

Options
    -o, --cookbook-path USERNAME     The directory where the cookbook will be created
    -C, --copyright COPYRIGHT_HOLDER The  name  of  the  copyright holder.
    -I, --license LICENSE            The type of license under which a cookbook is distributed: apachev2, gplv2, gplv3, mit, or none (default).
    -m, --email EMAIL                The  email  address  for the individual who maintains the cookbook.
    -d, --kitchen-driver DRIVER      The driver which use test-kitchen for creating platform instances: vagrant (default), docker
    -h, --help                       help
```

### Example

```
$ meez --cookbook-path /tmp --copyright Foo -I apachev2 -m foo@bah.com test
chef exec meez -o . test
* Initializing Cookbook
** Creating cookbook test
** Creating README for cookbook: test
** Creating CHANGELOG for cookbook: test
** Creating metadata for cookbook: test
  Rewriting metadata.rb
  Rewriting recipes/default.rb
* Initializing Berkshelf
      create  test/Berksfile
      create  test/Thorfile
      create  test/chefignore
      create  test/.gitignore
      create  test/Gemfile
* Initializing Vagrantfile
  Creating ./test/Vagrantfile from template
* Initializing Knife
adding chef gem to Gemfile
* Initializing Rakefile
  Creating ./test/Rakefile from template
adding rake gem to Gemfile
* Initializing Rubocop
  Creating ./test/.rubocop.yml from template
adding rubocop gem to Gemfile
* Initializing Food Critic
adding foodcritic gem to Gemfile
* Initializing Chef Spec
  Creating ./test/test/unit/spec/spec_helper.rb from template
  Creating ./test/test/unit/spec/default_spec.rb from template
adding chefspec gem to Gemfile
* Initializing Server Spec
  Creating ./test/test/integration/default/serverspec/spec_helper.rb from template
  Creating ./test/test/integration/default/serverspec/default_spec.rb from template
* Initializing Test Kitchen
      create  .kitchen.yml
      append  Rakefile
      append  Thorfile
       exist  test/integration/default
      append  .gitignore
      append  .gitignore
      append  Gemfile
      append  Gemfile
You must run `bundle install' to fetch any new gems.
  Creating ./test/.kitchen.yml from template
* Initializing Guard
  Creating ./test/Guardfile from template
adding guard gem to Gemfile
adding guard-rubocop gem to Gemfile
adding guard-foodcritic gem to Gemfile
* Initializing Drone
  Creating ./test/.drone.yml from template
* Initializing Docker
  Creating ./test/Dockerfile from template
Cookbook test created successfully
Next steps...
  $ cd ./test
  $ export USE_SYSTEM_GECODE=1
  $ chef exec rake prepare
  $ chef exec rake test
$ cd /tmp/test
$ export USE_SYSTEM_GECODE=1
$ chef exec rake prepare
chef exec bundle install --path .bundle
Fetching gem metadata from https://rubygems.org/.......
Fetching additional metadata from https://rubygems.org/..
Resolving dependencies...
Installing rake (10.3.2)
...
...
Your bundle is complete!
It was installed into ./.bundle
chef exec berks install
Resolving cookbook dependencies...
Fetching 'test' from source at .
Fetching cookbook index from https://supermarket.getchef.com...
Using test (0.1.0) from source at .
$ chef exec rake -T
rake kitchen:all                  # Run all test instances
rake kitchen:default-ubuntu-1204  # Run default-ubuntu-1204 test instance
rake prepare                      # Install required Gems and Cookbooks
rake prepare:chefdk               # Install ChefDK
rake style                        # Run all style checks
rake unit                         # Run all unit tests
```

Contributing
------------

e.g.

1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write your change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request using Github

License and Authors
-------------------

Authors:
========

Paul Czarkowski - paul.czarkowski@rackspace.com

License:
========

Copyright 2014 Paul Czarkowski,  Rackspace Inc.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
