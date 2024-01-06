# frozen_string_literal: true

require 'jwt'

require_relative 'auth_rails/config'
require_relative 'auth_rails/version'
require_relative 'auth_rails/class_methods'
require_relative 'auth_rails/configuration/jwt'
require_relative 'auth_rails/services/jwt_service'
require_relative 'auth_rails/strategies/base_strategy'
require_relative 'auth_rails/strategies/allowed_token_strategy'

module AuthRails
  class Error < StandardError; end

  class Engine < ::Rails::Engine
    isolate_namespace AuthRails

    config.autoload_paths << File.expand_path('app/models', __dir__)
    config.autoload_paths << File.expand_path('app/supports', __dir__)
    config.autoload_paths << File.expand_path('app/controllers', __dir__)
  end
end
