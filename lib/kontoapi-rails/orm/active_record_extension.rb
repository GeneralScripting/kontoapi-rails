module KontoAPI
  module ActiveRecordExtension

    def self.included(base)
      base.send(:extend, ClassMethods)
    end

    module ClassMethods
      def validates_bank_account(options={})
        options.symbolize_keys!
        class_eval do
          validates_with KontoAPI::BankAccountValidator, options
        end
        nil
      end
    end

  end
end