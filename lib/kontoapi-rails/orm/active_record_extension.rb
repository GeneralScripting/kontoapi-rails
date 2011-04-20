module KontoAPI
  module ActiveRecordExtension

    def self.included(base)
      base.send(:extend, ClassMethods)
    end

    module ClassMethods
      def validates_bank_account(options={})
        options.symbolize_keys!
        options.reverse_merge!(
          :account_number_field => :account_number,
          :bank_code_field      => :bank_code,
          :allow_nil            => true,
          :on_timeout           => :ignore
        )
        validates_with KontoAPI::BankAccountValidator, options
      end

      def autocomplete_bank_name(options={})
        options.symbolize_keys!
        options.reverse_merge!(
          :bank_code_field  => :bank_code,
          :bank_name_field  => :bank_name,
          :always_overwrite => false
        )
        define_method :autocomplete_bank_name do
          current_value = send(:"#{options[:bank_name_field]}")
          blz           = send(:"#{options[:bank_code_field]}")
          begin
            self.send(:"#{options[:bank_name_field]}=", KontoAPI::bank_name(blz)) if (options[:always_overwrite] || current_value.blank?) && blz.present?
          rescue Timeout::Error => ex
            case options[:on_timeout]
            when String
              self.send(:"#{options[:bank_name_field]}=", options[:on_timeout])
            when nil, :ignore
              # nop
            when :retry
              raise 'not implemented yet'
            end
          end
        end
        before_save :autocomplete_bank_name
      end
    end

  end
end