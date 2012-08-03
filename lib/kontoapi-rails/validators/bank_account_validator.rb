require 'active_model/validator'

module KontoAPI
  class BankAccountValidator < ActiveModel::Validator

    def validate(record)
      account_number  = record.send(:"#{options[:account_number_field]}")
      bank_code       = record.send(:"#{options[:bank_code_field]}")
      return true unless record.send(:"#{options[:account_number_field]}_changed?") || record.send(:"#{options[:bank_code_field]}_changed?")
      return true if options[:allow_nil] && (account_number.nil? || bank_code.nil?)
      record.errors.add(:"#{options[:account_number_field]}", :invalid) unless KontoAPI::valid?( :ktn => account_number, :blz => bank_code )
    rescue Timeout::Error => ex
      case options[:on_timeout]
      when :fail
        record.errors.add(:"#{options[:account_number_field]}", :timeout)
      when :ignore
        # nop
      when :retry
        raise 'not implemented yet'
      end
    end

  end
end