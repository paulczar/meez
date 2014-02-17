Meez
----

About
=====

`Meez` is slang for `mise en place`

`Mise en place` is a French phrase which means "putting in place", as in set up. It is used in professional kitchens to refer to organizing and arranging the ingredients (e.g., cuts of meat, relishes, sauces, par-cooked items, spices, freshly chopped vegetables, and other components) that a cook will require for the menu items that he or she expects to prepare during his/her shift.[1] The practice is also effective in home kitchens.

`Meez` will create an opinionated chef cookbook skeleton complete with testing suite. 

Install
=======

`gem install meez`

Usage
=====

```
Usage: meez [options] <cookbook name>

Options
    -o, --cookbook-path USERNAME     The directory where the cookbook will be created
    -C, --copyright COPYRIGHT_HOLDER The  name  of  the  copyright holder.
    -I, --license LICENSE            The type of license under which a cookbook is distributed: apachev2, gplv2, gplv3, mit, or none (default).
    -m, --email EMAIL                The  email  address  for the individual who maintains the cookbook.
    -h, --help                       help
```

### Example

```
meez --cookbook-path /tmp --copyright Foo -I apachev2 -m foo@bah.com test
* Initializing Cookbook
** Creating cookbook test
** Creating README for cookbook: test
** Creating CHANGELOG for cookbook: test
** Creating metadata for cookbook: test
	Rewriting metadata.rb
	Rewriting recipes/default.rb
* Initializing Berkshelf
      create  /tmp/test/Berksfile
      create  /tmp/test/Thorfile
      create  /tmp/test/.gitignore
         run  git init from "/tmp/test"
      create  /tmp/test/Gemfile
* Initializing Vagranfile
* Initializing Knife
	Append Gemfile
* Initializing Rakefile
	 Creating /tmp/test/Rakefile
* Initializing Rubocop
	Append Gemfile
* Initializing Food Critic
	Append Gemfile
* Initializing Chef Spec
	Creating /tmp/test/test/unit/spec/spec_helper.rb
	Creating /tmp/test/test/unit/spec/default_spec.rb
	Append Gemfile
* Initializing Server Spec
	 Creating /tmp/test/test/integration/default/serverspec/spec_helper.rb
	Creating /tmp/test/test/integration/default/serverspec/default_spec.rb
	Append Gemfile
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
Cookbook test created successfully
Next steps...
  $ cd /tmp/test
  $ bundle install
  $ bundle exec berks install

➜  cd /tmp/test
➜  bundle install
Fetching gem metadata from https://rubygems.org/
Fetching additional metadata from https://rubygems.org/
Resolving dependencies...
...
...
Your bundle is complete!
➜  bundle exec berks install
Using test (0.1.0) from metadata
➜  bundle exec rake -T
rake integration                  # Run Test Kitchen integration tests
rake kitchen:all                  # Run all test instances
rake kitchen:default-ubuntu-1204  # Run default-ubuntu-1204 test instance
rake spec                         # Run ChefSpec unit tests
rake style                        # Run all style checks
rake style:chef                   # Lint Chef cookbooks
rake style:ruby                   # Run Ruby style checks
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
