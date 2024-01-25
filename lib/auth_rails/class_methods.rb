# frozen_string_literal: true

module AuthRails
  class << self
    def configure
      yield Config
    end

    def configuration
      Config
    end

    def resource_class
      @resource_class ||= Config.resource_class
    end

    def identifier_name
      @identifier_name ||= Config.identifier_name.to_sym || :email
    end

    def error_class
      @error_class ||= Config.error_class || Error
    end

    def jwt_strategy
      @jwt_strategy ||= Configuration::Jwt.strategy || Strategies::BaseStrategy
    end

    def authenticate(resource:, password:)
      if Config.authenticate.present?
        raise 'Config.authenticate must be a Proc' unless Config.authenticate.is_a?(Proc)

        Config.authenticate.call(resource, password)
      else
        raise 'Don\'t know how to authenticate resource with password' unless resource.respond_to?(:authenticate)

        resource.authenticate(password)
      end
    end
  end
end
