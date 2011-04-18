module KontoAPI

  module Config

    class << self

      def api_key=(new_key)
        KontoAPI::api_key = new_key
      end

      def timeout=(new_timeout)
        KontoAPI::timeout = new_timeout
      end

    end

  end

  def self.setup
    yield KontoAPI::Config
  end

end