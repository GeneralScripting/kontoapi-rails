module KontoAPI
  module ActiveRecordExtension

    def self.included(base)
      base.send(:extend, ClassMethods)
    end

    module ClassMethods
      def validates_bank_account(options={})
        return if KontoAPI::Config.disable_for.include?(::Rails.env)
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
        return if KontoAPI::Config.disable_for.include?(::Rails.env)
        options.symbolize_keys!
        options.reverse_merge!(
          :bank_code_field  => :bank_code,
          :bank_name_field  => :bank_name,
          :always_overwrite => false
        )
        define_method :autocomplete_bank_name do
          current_value = send(:"#{options[:bank_name_field]}")
          blz           = send(:"#{options[:bank_code_field]}")
          blz_changed   = (respond_to?(:"#{options[:bank_code_field]}_changed?") && send(:"#{options[:bank_code_field]}_changed?")) || (respond_to?(:"encrypted_#{options[:bank_code_field]}_changed?") && send(:"encrypted_#{options[:bank_code_field]}_changed?"))
          begin
            self.send(:"#{options[:bank_name_field]}=", KontoAPI::bank_name(blz)) if (options[:always_overwrite] || current_value.blank?) && blz_changed
            return true
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

      def validates_iban(field, options={})
        return if KontoAPI::Config.disable_for.include?(::Rails.env)
        options.symbolize_keys!
        options.reverse_merge!( :allow_nil => true, :on_timeout => :ignore )
        define_method :iban_validation do
          value = send(field)
          return true if respond_to?(:"#{field}_changed?") && !send(:"#{field}_changed?")
          return true if respond_to?(:"encrypted_#{field}_changed?") && !send(:"encrypted_#{field}_changed?")
          return true if options[:allow_nil] && value.nil?
          begin
            errors.add(field, :invalid) unless KontoAPI::valid?( :iban => value )
          rescue Timeout::Error => ex
            case options[:on_timeout]
            when :fail
              errors.add(field, :timeout)
            when :ignore
              # nop
            end
          end
        end
        validate :iban_validation
      end

      def validates_bic(field, options={})
        return if KontoAPI::Config.disable_for.include?(::Rails.env)
        options.symbolize_keys!
        options.reverse_merge!( :allow_nil => true, :on_timeout => :ignore )
        define_method :bic_validation do
          value = send(field)
          return true if respond_to?(:"#{field}_changed?") && !send(:"#{field}_changed?")
          return true if respond_to?(:"encrypted_#{field}_changed?") && !send(:"encrypted_#{field}_changed?")
          return true if options[:allow_nil] && value.nil?
          begin
            errors.add(field, :invalid) unless KontoAPI::valid?( :bic => value )
          rescue Timeout::Error => ex
            case options[:on_timeout]
            when :fail
              errors.add(field, :timeout)
            when :ignore
              # nop
            end
          end
        end
        validate :bic_validation
      end

      def validates_iban_and_bic(iban_field, bic_field, options={})
        return if KontoAPI::Config.disable_for.include?(::Rails.env)
        options.symbolize_keys!
        options.reverse_merge!( :allow_nil => true, :on_timeout => :ignore )
        define_method :iban_and_bic_validation do
          iban_value = send(iban_field)
          bic_value = send(bic_field)
          return true if [iban_field, bic_field].all? do |field|
            respond_to?(:"#{field}_changed?") && !send(:"#{field}_changed?")
          end
          return true if [iban_field, bic_field].all? do |field|
            respond_to?(:"encrypted_#{field}_changed?") && !send(:"encrypted_#{field}_changed?")
          end
          return true if options[:allow_nil] && iban_value.nil? && bic_value.nil?
          begin
            unless KontoAPI::valid?( :iban => iban_value, :bic => bic_value )
              errors.add(iban_field, :invalid)
              errors.add(bic_field, :invalid)
            end
          rescue Timeout::Error => ex
            case options[:on_timeout]
            when :fail
              errors.add(field, :timeout)
            when :ignore
              # nop
            end
          end
        end
        validate :iban_and_bic_validation
      end
    end

  end
end