# Encoding: utf-8
# The main Meez driver
class Meez
  require 'fileutils'

  def self.init(cookbook_name, options)
    init_cookbook(cookbook_name, options)
    init_berkshelf(cookbook_name, options)
    init_vagrant(cookbook_name, options)
    init_strainer(cookbook_name, options)
    init_knife(cookbook_name, options)
    init_rubocop(cookbook_name, options)
    init_foodcritic(cookbook_name, options)
    init_chefspec(cookbook_name, options)
    init_serverspec(cookbook_name, options)
    init_kitchenci(cookbook_name, options)
    #bundle_install(cookbook_name, options)
  end

  def self.init_cookbook(cookbook_name, options)
    require 'chef/knife/cookbook_create'
    puts '* Initializing Cookbook'
    path = File.join(options[:path], cookbook_name)
    create_cookbook = Chef::Knife::CookbookCreate.new
    create_cookbook.name_args = [cookbook_name]
    create_cookbook.config[:cookbook_path]      = options[:path]
    create_cookbook.config[:cookbook_copyright] = options[:copyright] || 'YOUR_COMPANY_NAME'
    create_cookbook.config[:cookbook_license]   = options[:license]   || 'YOUR_EMAIL'
    create_cookbook.config[:cookbook_email]     = options[:email]     || 'none'
    create_cookbook.run
    %w{ metadata.rb recipes/default.rb }.each do |file|
      puts "\tRewriting #{file}"
      contents = "# Encoding: utf-8\n#{File.read(File.join(path, file))}"
      File.open(File.join(path, file), 'w') { |f| f.write(contents) }
    end
  end

  def self.init_git(cookbook_name, options)
    puts '* Initializing GIT repo'
    path = File.join(options[:path], cookbook_name)
    require 'git'
    Git.init( path, { repository: path } )
  end

    # Every Vagrant virtual environment requires a box to build off of.
  #config.vm.box = "<%= berkshelf_config.vagrant.vm.box %>"

  # The url from where the 'config.vm.box' box will be fetched if it
  # doesn't already exist on the user's system.
  #config.vm.box_url = "<%= berkshelf_config.vagrant.vm.box_url %>"

  def self.init_berkshelf(cookbook_name, options)
    puts '* Initializing Berkshelf'
    path = File.join(options[:path], cookbook_name)
    gem 'berkshelf', '~> 2.0.11'
    require 'berkshelf'
    require 'berkshelf/base_generator'
    require 'berkshelf/init_generator'
    Berkshelf::InitGenerator.new(
      [path],
      {
        skip_test_kitchen: true,
        skip_vagrant: true
      }
    ).invoke_all
    File.open(File.join(path, 'Berksfile'), 'a') { |f| f.write("metadata\n") }
  end

  def self.init_kitchenci(cookbook_name, options)
    puts '* Initializing Test Kitchen'
    path = File.join(options[:path], cookbook_name)
    require 'kitchen'
    require 'kitchen/generator/init'
    Kitchen::Generator::Init.new([], {}, destination_root: path).invoke_all
    File.open(File.join(path, 'Strainerfile'), 'a') { |f| f.write("kitchen:   bundle exec kitchen test --destroy=always\n") }
    File.open(File.join(path, '.kitchen.yml'), 'w') do |file|
      contents = <<-EOF
---
driver:
  name: vagrant

provisioner:
  name: chef_solo

platforms:
  - name: ubuntu-12.04

suites:
  - name: default
    run_list: recipe[#{cookbook_name}::default]
    attributes:
      EOF
      file.write(contents)
    end
  end

  def self.init_vagrant(cookbook_name, options)
    puts '* Initializing Vagranfile'
    path = File.join(options[:path], cookbook_name)
    File.open(File.join(path, 'Vagrantfile'), 'w') do |file|
      contents = <<-EOF
# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure('2') do |config|
  config.vm.hostname = '#{cookbook_name}'
  config.vm.box = 'ubuntu-12.04'
  config.vm.box_url = "http://opscode-vm-bento.s3.amazonaws.com/vagrant/virtualbox/opscode_\#{config.vm.box}_chef-provisionerless.box"
  config.omnibus.chef_version = 'latest'
  config.berkshelf.enabled = true

  config.vm.provision :chef_solo do |chef|
    chef.json = {
    }

    chef.run_list = [
        'recipe[#{cookbook_name}::default]'
    ]
  end
end
      EOF
      file.write(contents)
    end
  end

  def self.init_chefspec(cookbook_name, options)
    puts '* Initializing Chef Spec'
    path = File.join(options[:path], cookbook_name)
    spec_path = File.join(path, 'test', 'unit', 'spec')
    FileUtils.mkdir_p(spec_path)
    puts "\tCreating #{File.join(spec_path, 'spec_helper.rb')}"

    File.open(File.join(spec_path, 'spec_helper.rb'), 'w') do |file|
      contents = <<-EOF
# Encoding: utf-8
require 'chefspec'
require 'chefspec/berkshelf'
require 'chef/application'

::LOG_LEVEL = :fatal
::UBUNTU_OPTS = {
  :platform => 'ubuntu',
  :version => '12.04',
  :log_level => ::LOG_LEVEL
}
::CHEFSPEC_OPTS = {
  :log_level => ::LOG_LEVEL
}

def stub_resources
end

at_exit { ChefSpec::Coverage.report! }
      EOF
      file.write(contents)
    end

    puts "\tCreating #{File.join(spec_path, 'default_spec.rb')}"
    File.open(File.join(spec_path, 'default_spec.rb'), 'w') do |file|
      contents = <<-EOF
# Encoding: utf-8

require_relative 'spec_helper'

describe '#{cookbook_name}::default' do
  before { stub_resources }
  describe 'ubuntu' do
    let(:chef_run) { ChefSpec::Runner.new.converge(described_recipe) }

    it 'writes some chefspec code' do
      pending 'todo'
    end

  end
end
      EOF
      file.write(contents)
    end

    puts "\tAppend Gemfile"
    File.open(File.join(path, 'Gemfile'), 'a') { |f| f.write("gem 'chefspec', '~> 3.1.4'\n") }
    File.open(File.join(path, 'Strainerfile'), 'a') { |f| f.write("chefspec:   bundle exec rspec $SANDBOX/$COOKBOOK/test/unit/spec\n") }
  end

  def self.init_strainer(cookbook_name, options)
    puts '* Initializing Strainer'
    path = File.join(options[:path], cookbook_name)
    puts "\tCreating #{File.join(path, 'Strainerfile')}"
    File.open(File.join(path, 'Strainerfile'), 'w') { |f| f.write("# Strainerfile\n") }
    puts "\tAppend Gemfile"
    File.open(File.join(path, 'Gemfile'), 'a') { |f| f.write("gem 'strainer', '~> 3.3.0'\n") }
  end

  def self.init_rubocop(cookbook_name, options)
    puts '* Initializing Rubocop'
    path = File.join(options[:path], cookbook_name)
    puts "\tAppend Gemfile"
    File.open(File.join(path, 'Gemfile'), 'a') { |f| f.write("gem 'rubocop', '~> 0.16.0'\n") }
    puts "\tAppend Strainerfile"
    File.open(File.join(path, 'Strainerfile'), 'a') { |f| f.write("rubocop:    bundle exec rubocop $COOKBOOK\n") }
  end

  def self.init_knife(cookbook_name, options)
    puts '* Initializing Knife'
    path = File.join(options[:path], cookbook_name)
    puts "\tAppend Gemfile"
    File.open(File.join(path, 'Gemfile'), 'a') { |f| f.write("gem 'chef', '~> 11.8.0'\n") }
    puts "\tAppend Strainerfile"
    File.open(File.join(path, 'Strainerfile'), 'a') { |f| f.write("knife test: bundle exec knife cookbook test $COOKBOOK\n") }
  end

  def self.init_foodcritic(cookbook_name, options)
    puts '* Initializing Food Critic'
    path = File.join(options[:path], cookbook_name)
    puts "\tAppend Gemfile"
    File.open(File.join(path, 'Gemfile'), 'a') { |f| f.write("gem 'foodcritic', '~> 3.0.0'\n") }
    puts "\tAppend Strainerfile"
    File.open(File.join(path, 'Strainerfile'), 'a') { |f| f.write("foodcritic: bundle exec foodcritic -f any $SANDBOX/$COOKBOOK\n") }
  end

  def self.init_serverspec(cookbook_name, options)
    puts '* Initializing Server Spec'
    path = File.join(options[:path], cookbook_name)
    spec_path = File.join(path, 'test', 'integration', 'default', 'serverspec')
    FileUtils.mkdir_p(spec_path)
    puts "\t Creating #{File.join(spec_path, 'spec_helper.rb')}"

    File.open(File.join(spec_path, 'spec_helper.rb'), 'w') do |file|
      contents = <<-EOF
# Encoding: utf-8
require 'serverspec'

include Serverspec::Helper::Exec
include Serverspec::Helper::DetectOS

RSpec.configure do |c|
  c.before :all do
    c.path = '/sbin:/usr/bin'
  end
end
      EOF
      file.write(contents)
    end

    puts "\tCreating #{File.join(spec_path, 'default_spec.rb')}"
    File.open(File.join(spec_path, 'default_spec.rb'), 'w') do |file|
      contents = <<-EOF
# Encoding: utf-8

require_relative 'spec_helper'

describe 'default' do
  it { pending 'write some tests' }
end
      EOF
      file.write(contents)
    end

    puts "\tAppend Gemfile"
    File.open(File.join(path, 'Gemfile'), 'a') { |f| f.write("gem 'serverspec', '~> 0.14.2'\n") }
  end

  def self.bundle_install(cookbook_name, options)
    require 'bundler'
    puts '* Running bundle install'
    path = File.join(options[:path], cookbook_name)
    puts "\t append .gitignore"
    Bundler.with_clean_env { exec({ 'BUNDLE_GEMFILE' => '/tmp/test/Gemfile' }, 'bundle install') }
  end
end
