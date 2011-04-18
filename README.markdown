Konto API Rails Validator
=========================

This library is a wrapper for the Konto API (https://www.kontoapi.de/).
It provides a validation method for ActiveRecord models that checks if a given account number and bank code represent a valid combination.

INSTALLATION
------------

    $ [sudo] gem install kontoapi-rails

USAGE
-----

Add an initializer (e.g. kontoapi.rb) in `config/initializers`:

    KontoAPI.setup do |config|
      # mendatory
      config.api_key = '<your-api-key>' # get one at https://www.kontoapi.de/
      # optional (with defaults)
      config.timeout = 10
    end

Then, in one of the models you want to validate bank account data with:

    class PaymentData < ActiveRecord::Base
    
      # other validations
      validates :account_number, :bank_code, :presence => true
    
      # account data validation
      # (really just a shortcut for `validates_with KontoAPI::BankAccountValidator`)
      # takes any of the following options (the defaults are shown here):
      #   :account_number_field => :account_number,
      #   :bank_code_field      => :bank_code,
      #   :allow_nil            => true,    <-- don't validate if one of them is nil
      #   :on_timeout           => :ignore  <-- do nothing if a timeout occurs, others:
      #                            :fail    <-- throw a validation error
      #                            :retry   <-- (not supported yet)
      validates_account_data
    
    end

Copyright
---------

Copyright (c) 2011 General Scripting - Jan Schwenzien. See LICENSE for further details.

