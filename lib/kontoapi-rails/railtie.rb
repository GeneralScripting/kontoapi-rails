require 'rails'
# ensure ORMs are loaded *before* initializing
begin; require 'mongoid'; rescue LoadError; end

require File.join(File.dirname(__FILE__), 'validators/bank_account_validator')

module KontoAPI
  class Railtie < ::Rails::Railtie #:nodoc:
    initializer 'kontoapi' do |app|
      ActiveSupport.on_load(:active_record) do
        require File.join(File.dirname(__FILE__), 'orm/active_record_extension')
        ::ActiveRecord::Base.send :include, KontoAPI::ActiveRecordExtension
      end
      if defined? ::Mongoid
        require File.join(File.dirname(__FILE__), 'orm/mongoid_extension')
        #::Mongoid::Document.send :include, KontoAPI::MongoidExtension::Document
        #::Mongoid::Criteria.send :include, KontoAPI::MongoidExtension::Criteria
      end
    end
  end
end