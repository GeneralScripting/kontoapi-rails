Konto API Rails Validator
=========================

[![Gem Version](https://badge.fury.io/rb/kontoapi-rails.png)](http://badge.fury.io/rb/kontoapi-rails)


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
      # Takes any of the following options (the defaults are shown here):
      #   :account_number_field => :account_number,
      #   :bank_code_field      => :bank_code,
      #   :allow_nil            => true,    <-- don't validate if one of them is nil
      #   :on_timeout           => :ignore  <-- do nothing if a timeout occurs, others:
      #                            :fail    <-- throw a validation error
      #                            :retry   <-- (not supported yet)
      #
      # If validations fails, an error within the standard ActiveRecord I18n scopes
      # will be added to the :account_number_field:
      # :invalid <-- if it is invalid
      # :timeout <-- if :on_timeout is set to :fail and the api call timed out
      validates_bank_account
      
      # IBAN validation
      # Check if the given IBAN is valid
      # Takes any of the following options (the defaults are shown here):
      #   :allow_nil            => true,    <-- don't validate if nil
      #   :on_timeout           => :ignore  <-- do nothing if a timeout occurs, others:
      #                            :fail    <-- throw a validation error
      #                            :retry   <-- (not supported yet)
      validates_iban :iban
      
      # BIC validation
      # Check if the given BIC exists
      # Takes any of the following options (the defaults are shown here):
      #   :allow_nil            => true,    <-- don't validate if nil
      #   :on_timeout           => :ignore  <-- do nothing if a timeout occurs, others:
      #                            :fail    <-- throw a validation error
      #                            :retry   <-- (not supported yet)
      validates_bic :bic
    
    end

And if you want to autocomplete the bank name:

    class PaymentData < ActiveRecord::Base

      # bank name autocompletion
      # takes any of the following options (the defaults are shown here):
      #   :bank_code_field      => :bank_code,
      #   :bank_name_field      => :bank_name,
      #   :always_overwrite     => false,         <-- autocomplete even if bank name already present
      #   :on_timeout           => :ignore        <-- do nothing if a timeout occurs, others:
      #                            :retry         <-- (not supported yet)
      #                             'any string'  <-- use this string as the value
      autocomplete_bank_name
    
    end

Copyright
---------

Copyright (c) 2011-2012 General Scripting UG (haftungsbeschränkt). See LICENSE for further details.

