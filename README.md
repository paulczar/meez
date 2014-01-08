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
      create  /tmp/test/Vagrantfile
* Initializing Strainer
    Creating /tmp/test/Strainerfile
    Append Gemfile
* Initializing Knife
    Append Gemfile
    Append Strainerfile
* Initializing Rubocop
    Append Gemfile
    Append Strainerfile
* Initializing Food Critic
    Append Gemfile
    Append Strainerfile
* Initializing Chef Spec
    Creating /tmp/test/spec/spec_helper.rb
    Creating /tmp/test/spec/default_spec.rb
    Append Gemfile
* Initializing Server Spec
     Creating /tmp/test/test/integration/default/serverspec/spec_helper.rb
    Creating /tmp/test/test/integration/default/serverspec/default_spec.rb
    Append Gemfile
* Initializing Test Kitchen
      create  .kitchen.yml
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
  $ bundle exec strainer test

➜  cd ../test
➜  bundle install
Fetching gem metadata from https://rubygems.org/
Fetching additional metadata from https://rubygems.org/
Resolving dependencies...
...
...
Your bundle is complete!
➜  bundle exec berks install
Using test (0.1.0) from metadata
➜  bundle exec strainer test
# Straining 'test (v0.1.0)'
knife test           | bundle exec knife cookbook test test
knife test           | checking test
knife test           | Running syntax check on test
knife test           | Validating ruby files
knife test           | Validating templates
knife test           | SUCCESS!
rubocop              | bundle exec rubocop test
rubocop              | Inspecting 6 files
rubocop              | ......
rubocop              | 6 files inspected, no offences detected
rubocop              | SUCCESS!
foodcritic           | bundle exec foodcritic -f any /private/tmp/test
foodcritic           | SUCCESS!
chefspec             | bundle exec rspec /private/tmp/test/spec
chefspec             | *
chefspec             | Pending:
chefspec             | test::default ubuntu writes some tests
chefspec             | # or it gets the hose again
chefspec             | # /private/tmp/test/spec/default_spec.rb:13
chefspec             | Finished in 0.02869 seconds
chefspec             | 1 example, 0 failures, 1 pending
chefspec             | SUCCESS!
kitchen              | bundle exec kitchen test --destroy=always
kitchen              | -----> Starting Kitchen (v1.1.1)
kitchen              | -----> Cleaning up any prior instances of <default-ubuntu-1204>
kitchen              | -----> Destroying <default-ubuntu-1204>...
kitchen              |        Finished destroying <default-ubuntu-1204> (0m0.00s).
kitchen              | -----> Testing <default-ubuntu-1204>
kitchen              | -----> Creating <default-ubuntu-1204>...
kitchen              |        Bringing machine 'default' up with 'virtualbox' provider...
kitchen              |        [default] Importing base box 'opscode-ubuntu-12.04'...
       [default] Matching MAC address for NAT networking...
kitchen              |        [default] Setting the name of the VM...
kitchen              |        [default] Clearing any previously set forwarded ports...
kitchen              |        [Berkshelf] Skipping Berkshelf with --no-provision
kitchen              |        [default] Fixed port collision for 22 => 2222. Now on port 2206.
kitchen              |        [default] Clearing any previously set network interfaces...
kitchen              |        [default] Preparing network interfaces based on configuration...
kitchen              |        [default] Forwarding ports...
kitchen              |        [default] -- 22 => 2206 (adapter 1)
kitchen              |        [default] Running 'pre-boot' VM customizations...
kitchen              |        [default] Booting VM...
kitchen              |        [default] Waiting for machine to boot. This may take a few minutes...
kitchen              |        [default] Machine booted and ready!
kitchen              |        [default] The guest additions on this VM do not match the installed version of
kitchen              |        VirtualBox! In most cases this is fine, but in rare cases it can
kitchen              |        prevent things such as shared folders from working properly. If you see
kitchen              |        shared folder errors, please make sure the guest additions within the
kitchen              |        virtual machine match the version of VirtualBox you have installed on
kitchen              |        your host and reload your VM.
kitchen              |
kitchen              |        Guest Additions Version: 4.2.12
kitchen              |        VirtualBox Version: 4.3
kitchen              |        [default] Setting hostname...
kitchen              |        Vagrant instance <default-ubuntu-1204> created.
kitchen              |        Finished creating <default-ubuntu-1204> (0m38.81s).
kitchen              | -----> Converging <default-ubuntu-1204>...
kitchen              |        Preparing files for transfer
kitchen              |        Resolving cookbook dependencies with Berkshelf...
kitchen              |        Removing non-cookbook files before transfer
kitchen              | -----> Installing Chef Omnibus (true)
kitchen              |        downloading https://www.opscode.com/chef/install.sh
kitchen              |          to file /tmp/install.sh
kitchen              |        trying wget...
kitchen              | Downloading Chef  for ubuntu...
kitchen              | downloading https://www.opscode.com/chef/metadata?v=&prerelease=false&p=ubuntu&pv=12.04&m=x86_64
kitchen              |   to file /tmp/install.sh.1098/metadata.txt
kitchen              | trying wget...
kitchen              | url  https://opscode-omnibus-packages.s3.amazonaws.com/ubuntu/12.04/x86_64/chef_11.8.2-1.ubuntu.12.04_amd64.deb
kitchen              | md5  3d3b3662830a44eeec71aadc098a4018
kitchen              | sha256   a5b00a24e68e29a01c7ab9de5cdaf0cc9fd1c889599ad9af70293e5b4de8615c
kitchen              | downloaded metadata file looks valid...
kitchen              | downloading https://opscode-omnibus-packages.s3.amazonaws.com/ubuntu/12.04/x86_64/chef_11.8.2-1.ubuntu.12.04_amd64.deb
kitchen              |   to file /tmp/install.sh.1098/chef__amd64.deb
kitchen              | trying wget...
kitchen              | Checksum compare with sha256sum succeeded.
kitchen              | Installing Chef
kitchen              | installing with dpkg...
kitchen              | Selecting previously unselected package chef.
(Reading database ... 53291 files and directories currently installed.)
kitchen              | Unpacking chef (from .../chef__amd64.deb) ...
kitchen              | Setting up chef (11.8.2-1.ubuntu.12.04) ...
kitchen              | Thank you for installing Chef!
kitchen              |        Transfering files to <default-ubuntu-1204>
kitchen              | [2014-01-08T20:57:27+00:00] INFO: Forking chef instance to converge...
kitchen              | Starting Chef Client, version 11.8.2
kitchen              | [2014-01-08T20:57:27+00:00] INFO: *** Chef 11.8.2 ***
kitchen              | [2014-01-08T20:57:27+00:00] INFO: Chef-client pid: 1175
kitchen              | [2014-01-08T20:57:27+00:00] INFO: Setting the run_list to ["recipe[test::default]"] from JSON
kitchen              | [2014-01-08T20:57:27+00:00] INFO: Run List is [recipe[test::default]]
kitchen              | [2014-01-08T20:57:27+00:00] INFO: Run List expands to [test::default]
kitchen              | [2014-01-08T20:57:27+00:00] INFO: Starting Chef Run for default-ubuntu-1204
kitchen              | [2014-01-08T20:57:27+00:00] INFO: Running start handlers
kitchen              | [2014-01-08T20:57:27+00:00] INFO: Start handlers complete.
kitchen              | Compiling Cookbooks...
kitchen              | Converging 0 resources
kitchen              | [2014-01-08T20:57:27+00:00] INFO: Chef Run complete in 0.003621599 seconds
kitchen              | [2014-01-08T20:57:27+00:00] INFO: Running report handlers
kitchen              | [2014-01-08T20:57:27+00:00] INFO: Report handlers complete
kitchen              | Chef Client finished, 0 resources updated
kitchen              |        Finished converging <default-ubuntu-1204> (0m10.71s).
kitchen              | -----> Setting up <default-ubuntu-1204>...
Fetching: thor-0.18.1.gem (100%) thor-0.18.1.gem
Fetching: busser-0.6.0.gem (100%)busser-0.6.0.gem
kitchen              | Successfully installed thor-0.18.1
kitchen              | Successfully installed busser-0.6.0
kitchen              | 2 gems installed
kitchen              | -----> Setting up Busser
kitchen              |        Creating BUSSER_ROOT in /tmp/busser
kitchen              |        Creating busser binstub
kitchen              |        Plugin serverspec installed (version 0.2.5)
kitchen              | -----> Running postinstall for serverspec plugin
kitchen              |        Finished setting up <default-ubuntu-1204> (0m17.94s).
kitchen              | -----> Verifying <default-ubuntu-1204>...
kitchen              |        Suite path directory /tmp/busser/suites does not exist, skipping.
kitchen              | Uploading /tmp/busser/suites/serverspec/default_spec.rb (mode=0644)
kitchen              | Uploading /tmp/busser/suites/serverspec/spec_helper.rb (mode=0644)
kitchen              | -----> Running serverspec test suite
kitchen              | /opt/chef/embedded/bin/ruby -I/tmp/busser/suites/serverspec -S /opt/chef/embedded/bin/rspec /tmp/busser/suites/serverspec/default_spec.rb --color --format documentation
kitchen              |
kitchen              | default
kitchen              |   example at /tmp/busser/suites/serverspec/default_spec.rb:6 (PENDING: write some tests)
kitchen              |
kitchen              | Pending:
kitchen              |   default
kitchen              |     # write some tests
kitchen              |     # /tmp/busser/suites/serverspec/default_spec.rb:6
kitchen              |
kitchen              | Finished in 0.03395 seconds
kitchen              | 1 example, 0 failures, 1 pending
kitchen              |        Finished verifying <default-ubuntu-1204> (0m1.60s).
kitchen              |        Finished testing <default-ubuntu-1204> (1m9.08s).
kitchen              | -----> Destroying <default-ubuntu-1204>...
kitchen              |        [default] Forcing shutdown of VM...
kitchen              |        [default] Destroying VM and associated drives...
kitchen              |        Vagrant instance <default-ubuntu-1204> destroyed.
kitchen              |        Finished destroying <default-ubuntu-1204> (0m4.89s).
kitchen              | -----> Kitchen is finished. (1m14.28s)
kitchen              | SUCCESS!
Strainer marked build as success
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
Paul Czarkowski - paul.czarkowski@rackspace.com

License:

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