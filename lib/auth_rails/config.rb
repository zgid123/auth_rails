# frozen_string_literal: true

module AuthRails
  class Config
    class << self
      attr_accessor :dig_params,
                    :error_class,
                    :authenticate,
                    :resource_class,
                    :identifier_name,
                    :retrieve_resource

      def jwt
        yield Configuration::Jwt
      end
    end
  end
end
