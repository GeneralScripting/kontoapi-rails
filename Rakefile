require 'rubygems'
require 'bundler'
begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end
require 'rake'

require 'jeweler'
Jeweler::Tasks.new do |gem|
  # gem is a Gem::Specification... see http://docs.rubygems.org/read/chapter/20 for more options
  gem.name = "kontoapi-rails"
  gem.homepage = "http://github.com/GeneralScripting/kontoapi-rails"
  gem.license = "MIT"
  gem.summary = %Q{A wrapper for the Konto API (https://www.kontoapi.de/) providing model validation.}
  gem.description = %Q{This library is a wrapper for the Konto API (https://www.kontoapi.de/). It provides a validation method for models that checks if a given account number and bank code represent a valid combination.}
  gem.email = "jan@schwenzien.org"
  gem.authors = ["Jan Schwenzien", "Jiayi Zheng"]
end
Jeweler::RubygemsDotOrgTasks.new

require 'rspec/core'
require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec) do |spec|
  spec.pattern = FileList['spec/**/*_spec.rb']
end

RSpec::Core::RakeTask.new(:rcov) do |spec|
  spec.pattern = 'spec/**/*_spec.rb'
  spec.rcov = true
end

task :default => :spec

require 'rdoc/task'
Rake::RDocTask.new do |rdoc|
  version = File.exist?('VERSION') ? File.read('VERSION') : ""

  rdoc.rdoc_dir = 'rdoc'
  rdoc.title = "kontoapi-rails #{version}"
  rdoc.rdoc_files.include('README*')
  rdoc.rdoc_files.include('lib/**/*.rb')
end
