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
      @identifier_name ||= Config.identifier_name&.to_sym || :email
    end

    def error_class
      @error_class ||= Config.error_class || Error
    end

    def jwt_strategy
      @jwt_strategy ||= Configuration::Jwt.strategy || Strategies::BaseStrategy
    end

    def authenticate(resource:, password:)
      if Config.authenticate.present?
        raise_if_not_proc(Config.authenticate, 'Config.authenticate')

        Config.authenticate.call(resource, password)
      else
        raise 'Don\'t know how to authenticate resource with password' unless resource.respond_to?(:authenticate)

        resource.authenticate(password)
      end
    end

    def dig_params(params:)
      if Config.dig_params.present?
        raise_if_not_proc(Config.dig_params, 'Config.dig_params')

        Config.dig_params.call(params)
      else
        params[AuthRails.identifier_name]
      end
    end

    def retrieve_resource(params:)
      identifier = dig_params(params: params)

      if Config.retrieve_resource.present?
        raise_if_not_proc(Config.retrieve_resource, 'Config.retrieve_resource')

        return Config.retrieve_resource.call(identifier)
      end

      AuthRails.resource_class.find_by(AuthRails.identifier_name => identifier)
    end

    private

    def raise_if_not_proc(source, name)
      raise "#{name} must be a Proc" unless source.is_a?(Proc)
    end
  end
end
