# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-
# stub: kontoapi-rails 0.3.1 ruby lib

Gem::Specification.new do |s|
  s.name = "kontoapi-rails"
  s.version = "0.3.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib"]
  s.authors = ["Jan Schwenzien", "Jiayi Zheng"]
  s.date = "2017-03-08"
  s.description = "This library is a wrapper for the Konto API (https://www.kontoapi.de/). It provides a validation method for models that checks if a given account number and bank code represent a valid combination."
  s.email = "jan@schwenzien.org"
  s.extra_rdoc_files = [
    "LICENSE",
    "README.markdown"
  ]
  s.files = [
    ".document",
    ".rspec",
    "Gemfile",
    "Gemfile.lock",
    "LICENSE",
    "README.markdown",
    "Rakefile",
    "VERSION",
    "init.rb",
    "kontoapi-rails.gemspec",
    "lib/kontoapi-rails.rb",
    "lib/kontoapi-rails/config.rb",
    "lib/kontoapi-rails/orm/active_record_extension.rb",
    "lib/kontoapi-rails/orm/mongoid_extension.rb",
    "lib/kontoapi-rails/railtie.rb",
    "lib/kontoapi-rails/validators/bank_account_validator.rb",
    "spec/kontoapi-rails_spec.rb",
    "spec/spec_helper.rb"
  ]
  s.homepage = "http://github.com/GeneralScripting/kontoapi-rails"
  s.licenses = ["MIT"]
  s.rubygems_version = "2.4.8"
  s.summary = "A wrapper for the Konto API (https://www.kontoapi.de/) providing model validation."

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<rails>, [">= 3.0.0"])
      s.add_runtime_dependency(%q<kontoapi-ruby>, [">= 0.2.0"])
      s.add_development_dependency(%q<rspec>, [">= 2.3.0"])
      s.add_development_dependency(%q<bundler>, [">= 1.1.0"])
      s.add_development_dependency(%q<jeweler>, [">= 1.5.2"])
      s.add_development_dependency(%q<simplecov>, [">= 0"])
      s.add_development_dependency(%q<rdoc>, [">= 0"])
    else
      s.add_dependency(%q<rails>, [">= 3.0.0"])
      s.add_dependency(%q<kontoapi-ruby>, [">= 0.2.0"])
      s.add_dependency(%q<rspec>, [">= 2.3.0"])
      s.add_dependency(%q<bundler>, [">= 1.1.0"])
      s.add_dependency(%q<jeweler>, [">= 1.5.2"])
      s.add_dependency(%q<simplecov>, [">= 0"])
      s.add_dependency(%q<rdoc>, [">= 0"])
    end
  else
    s.add_dependency(%q<rails>, [">= 3.0.0"])
    s.add_dependency(%q<kontoapi-ruby>, [">= 0.2.0"])
    s.add_dependency(%q<rspec>, [">= 2.3.0"])
    s.add_dependency(%q<bundler>, [">= 1.1.0"])
    s.add_dependency(%q<jeweler>, [">= 1.5.2"])
    s.add_dependency(%q<simplecov>, [">= 0"])
    s.add_dependency(%q<rdoc>, [">= 0"])
  end
end

