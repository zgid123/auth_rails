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

    def error_class
      @error_class ||= Config.error_class || Error
    end

    def jwt_strategy
      @jwt_strategy ||= Configuration::Jwt.strategy || Strategies::BaseStrategy
    end
  end
end
