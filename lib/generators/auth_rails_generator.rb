# frozen_string_literal: true

class AuthRailsGenerator < Rails::Generators::Base
  source_root File.expand_path('templates', __dir__)

  class_option :strategy,
               aliases: '-strat',
               type: :string,
               desc: 'Strategy to use, default is AuthRails::Strategies::BaseStrategy',
               default: 'base'

  class_option :model,
               aliases: '-m',
               type: :string,
               desc: 'Model for strategy to associate with',
               default: 'user'

  def generate_auth_rails
    @model = (options[:model] || 'user').camelcase
    @is_allowed_token = options[:strategy] == 'allowed_token'

    template(
      'auth_rails.tt',
      'config/initializers/auth_rails.rb'
    )
  end

  def create_allowed_tokens_strategy
    return if options[:strategy].blank? || options[:strategy] != 'allowed_token'

    invoke(
      'auth_rails:migration',
      [],
      strategy: 'allowed_token',
      model: (options[:model] || 'user').camelcase
    )
  end
end
