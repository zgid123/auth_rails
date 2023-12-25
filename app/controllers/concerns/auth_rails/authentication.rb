# frozen_string_literal: true

module AuthRails
  module Authentication
    extend ActiveSupport::Concern

    def authenticate_user!
      payload = Services::JwtService.verify_token(
        token: lookup_access_token,
        secret_key: Configuration::Jwt::AccessToken.secret_key
      )

      CurrentAuth.user = AuthRails.resource_class.find_by(email: payload[:sub])

      raise AuthRails.error_class, :unauthenticated unless CurrentAuth.user
    end

    private

    def lookup_access_token
      token_match = request.headers['Authorization']&.match(/bearer (.+)/i)
      token_match[1] if token_match
    end

    def lookup_refresh_token
      cookies[Configuration::Jwt::RefreshToken.cookie_key.to_sym].presence || params[:refresh_token]
    end
  end
end
