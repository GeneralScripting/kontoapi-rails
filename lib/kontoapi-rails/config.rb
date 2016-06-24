module KontoAPI

  module Config

    @@disable_for = ['development', 'test']

    class << self

      def api_key=(new_key)
        KontoAPI::api_key = new_key
      end

      def timeout=(new_timeout)
        KontoAPI::timeout = new_timeout
      end

      def disable_for
        @@disable_for
      end

      def disable_for=(disable_for)
        @@disable_for = disable_for
      end

    end

  end

  def self.setup
    yield KontoAPI::Config
  end

end