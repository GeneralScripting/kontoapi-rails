require 'active_model/validator'

module KontoAPI
  class BankAccountValidator < ActiveModel::Validator

    DEFAULTS = {
      :account_number_field => :account_number,
      :bank_code_field      => :bank_code,
      :allow_nil            => true,
      :on_timeout           => :ignore
    }

    def validate(record)
      record_options  = options.reverse_merge(DEFAULTS)
      account_number  = record.send(:"#{record_options[:account_number_field]}")
      bank_code       = record.send(:"#{record_options[:bank_code_field]}"))
      record.errors[:"#{record_options[:account_number_field]}"] << :invalid  unless KontoAPI::valid?(account_number, bank_code)
    rescue Timeout::Error => ex
      case record_options[:on_timeout]
      when :fail
        record.errors[:"#{record_options[:account_number_field]}"] << :timeout
      when :ignore
        # nop
      when :retry
        raise 'not implemented yet'
      end
    end

  end
end