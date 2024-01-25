# frozen_string_literal: true

module AuthRails
  class Config
    class << self
      attr_accessor :error_class,
                    :authenticate,
                    :resource_class,
                    :identifier_name

      def jwt
        yield Configuration::Jwt
      end
    end
  end
end
