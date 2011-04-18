module KontoAPI
  module ActiveRecordExtension

    def self.included(base)
      base.send(:extend, ClassMethods)
    end

    module ClassMethods
      def validates_bank_account(options={})
        options.symbolize_keys!
        validates_with KontoAPI::BankAccountValidator, options
      end

      def autocomplete_bank_name(options={})
        options.symbolize_keys!
        options.reverse_merge!(
          :bank_code_field  => :bank_code,
          :bank_name_field  => :bank_name
        )
        #write_inheritable_attribute(:autocomplete_bank_name_options, options)
        define_method :autocomplete_bank_name do
          current_value = send(:"#{options[:bank_name_field]}")
          blz           = send(:"#{options[:bank_code_field]}")
          self.send(:"#{options[:bank_name_field]}=", KontoAPI::bank_name(blz)) if current_value.blank? && blz.present?
        end
        before_save :autocomplete_bank_name
      end
    end

  end
end