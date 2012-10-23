require 'active_model/validator'

module KontoAPI
  class BankAccountValidator < ActiveModel::Validator

    def validate(record)
      account_number  = record.send(:"#{options[:account_number_field]}")
      bank_code       = record.send(:"#{options[:bank_code_field]}")
      account_number_changed = record.send( change_method(record, options[:account_number_field]) )
      bank_code_changed      = record.send( change_method(record, options[:bank_code_field]) )
      return true unless account_number_changed || bank_code_changed
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

    def change_method(record, field)
      ["#{field}_changed?", "encrypted_#{field}_changed?"].each do |m|
        return m.to_sym if record.respond_to?( m.to_sym )
      end
    end

  end
end