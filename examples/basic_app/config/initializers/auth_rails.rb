# frozen_string_literal: true

AuthRails.configure do |config|
  config.jwt do |jwt|
    jwt.access_token do |access_token|
      access_token.exp = 1.hour.since
      access_token.secret_key = ENV.fetch('JWT_SECRET', '')
    end

    jwt.strategy = AuthRails::Strategies::AllowedTokenStrategy

    jwt.refresh_token do |refresh_token|
      refresh_token.http_only = true
      refresh_token.exp = 1.year.since
      refresh_token.algorithm = 'HS256'
      refresh_token.cookie_key = :ref_tok
      refresh_token.secret_key = ENV.fetch('JWT_SECRET', '')
    end
  end
end

Rails.application.config.to_prepare do
  AuthRails.configure do |config|
    config.resource_class = User
  end
end
