# Encoding: utf-8
# The main Meez driver
class Meez
  require 'fileutils'

  def self.init(cookbook_name, options)
    init_cookbook(cookbook_name, options)
    init_berkshelf(cookbook_name, options)
    init_vagrant(cookbook_name, options)
    init_knife(cookbook_name, options)
    init_rakefile(cookbook_name, options)
    init_rubocop(cookbook_name, options)
    init_foodcritic(cookbook_name, options)
    init_chefspec(cookbook_name, options)
    init_serverspec(cookbook_name, options)
    init_kitchenci(cookbook_name, options)
    init_guard(cookbook_name, options)
    init_drone(cookbook_name, options)
  end

  def self.write_template(name, path, cookbook_name, options)
    require 'erb'
    template = File.join(File.dirname(__FILE__), '../../templates', name)
    target = File.join(path, File.basename(name, '.erb'))
    puts "\tCreating #{target} from template"
    content = ERB.new File.new(template).read
    File.open(target, 'w') { |f| f.write(content.result(binding)) }
  end

  def self.append_file(file, content)
    File.open(file, 'a') { |f| f.write("#{content}\n") }
  end

  def self.add_gem(cookbook_path, name, version = nil)
    puts "adding #{name} gem to Gemfile"
    if version
      append_file(File.join(cookbook_path, 'Gemfile'), "gem '#{name}', '#{version}'")
    else
      append_file(File.join(cookbook_path, 'Gemfile'), "gem '#{name}'")
    end
  end

  def self.gitignore(cookbook_path, file)
    append_file(File.join(cookbook_path, '.gitignore'), file)
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
    Git.init(path, repository: path)
  end

  def self.init_berkshelf(cookbook_name, options)
    puts '* Initializing Berkshelf'
    path = File.join(options[:path], cookbook_name)
    gem 'berkshelf', '~> 2.0.11'
    require 'berkshelf'
    require 'berkshelf/base_generator'
    require 'berkshelf/init_generator'
    Berkshelf::InitGenerator.new(
      [path],
      skip_test_kitchen: true,
      skip_vagrant: true
    ).invoke_all
    append_file(File.join(path, 'Berksfile'), 'metadata')
  end

  def self.init_kitchenci(cookbook_name, options)
    puts '* Initializing Test Kitchen'
    path = File.join(options[:path], cookbook_name)
    require 'kitchen'
    require 'kitchen/generator/init'
    Kitchen::Generator::Init.new([], {}, destination_root: path).invoke_all
    write_template('.kitchen.yml.erb', path, cookbook_name, options)
  end

  def self.init_vagrant(cookbook_name, options)
    puts '* Initializing Vagranfile'
    path = File.join(options[:path], cookbook_name)
    write_template('Vagrantfile.erb', path, cookbook_name, options)
  end

  def self.init_chefspec(cookbook_name, options)
    puts '* Initializing Chef Spec'
    path = File.join(options[:path], cookbook_name)
    spec_path = File.join(path, 'test', 'unit', 'spec')
    FileUtils.mkdir_p(spec_path)
    write_template('chefspec/spec_helper.rb.erb', spec_path, cookbook_name, options)
    write_template('chefspec/default_spec.rb.erb', spec_path, cookbook_name, options)
    gitignore(path, '.coverage/*')
    add_gem(path, 'chefspec', '~> 3.2')
  end

  def self.init_rakefile(cookbook_name, options)
    puts '* Initializing Rakefile'
    path = File.join(options[:path], cookbook_name)
    write_template('Rakefile.erb', path, cookbook_name, options)
    add_gem(path, 'rake')
  end

  def self.init_rubocop(cookbook_name, options)
    puts '* Initializing Rubocop'
    path = File.join(options[:path], cookbook_name)
    add_gem(path, 'rubocop', '~> 0.18')
  end

  def self.init_knife(cookbook_name, options)
    puts '* Initializing Knife'
    path = File.join(options[:path], cookbook_name)
    add_gem(path, 'chef', '~> 11.8')
  end

  def self.init_foodcritic(cookbook_name, options)
    puts '* Initializing Food Critic'
    path = File.join(options[:path], cookbook_name)
    add_gem(path, 'foodcritic', '~> 3.0')
  end

  def self.init_serverspec(cookbook_name, options)
    puts '* Initializing Server Spec'
    path = File.join(options[:path], cookbook_name)
    spec_path = File.join(path, 'test', 'integration', 'default', 'serverspec')
    FileUtils.mkdir_p(spec_path)
    write_template('serverspec/spec_helper.rb.erb', spec_path, cookbook_name, options)
    write_template('serverspec/default_spec.rb.erb', spec_path, cookbook_name, options)
    add_gem(path, 'serverspec', '~> 0.14')
  end

  def self.init_guard(cookbook_name, options)
    puts '* Initializing Guard'
    path = File.join(options[:path], cookbook_name)
    write_template('Guardfile.erb', path, cookbook_name, options)
    add_gem(path, 'guard', '~> 1.8')
    add_gem(path, 'guard-rubocop', '~> 0.2')
  end

  def self.init_drone(cookbook_name, options)
    puts '* Initializing Drone'
    path = File.join(options[:path], cookbook_name)
    write_template('.drone.yml.erb', path, cookbook_name, options)
  end

  def self.bundle_install(cookbook_name, options)
    require 'bundler'
    puts '* Running bundle install'
    path = File.join(options[:path], cookbook_name)
    puts "\t append .gitignore"
    Bundler.with_clean_env { exec({ 'BUNDLE_GEMFILE' => "#{path}/Gemfile" }, 'bundle install') }
  end
end
