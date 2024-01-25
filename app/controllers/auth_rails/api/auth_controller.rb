# frozen_string_literal: true

module AuthRails
  module Api
    class AuthController < ApiController
      def create
        resource = AuthRails.resource_class.find_by(email: params[:email])

        raise AuthRails.error_class, :unauthenticated if resource.blank? || !AuthRails.authenticate(resource: resource, password: params[:password])

        respond_to_create(generate_token(resource))
      end

      def refresh
        decoded_payload = Services::JwtService.verify_token(
          token: lookup_refresh_token,
          algorithm: Configuration::Jwt::RefreshToken.algorithm,
          secret_key: Configuration::Jwt::RefreshToken.secret_key
        )

        resource = AuthRails.jwt_strategy.retrieve_resource(payload: decoded_payload)

        raise AuthRails.error_class, :unauthenticated if resource.blank?

        resource.allowed_tokens.find_by(
          jti: decoded_payload[:jti],
          aud: decoded_payload[:aud]
        )&.destroy!

        respond_to_refresh(generate_token(resource))
      end

      private

      def respond_to_create(data)
        render json: {
          **data,
          user: CurrentAuth.user
        }
      end

      alias respond_to_refresh respond_to_create

      def payload(resource)
        {
          sub: resource.send(AuthRails.identifier_name)
        }
      end

      def basic_payload
        {
          aud: request.host
        }
      end

      def generate_token(resource)
        CurrentAuth.user = resource
        token_payload = basic_payload.merge(payload(resource))

        result = {
          access_token: Services::JwtService.gen_token(
            payload: token_payload,
            secret_key: Configuration::Jwt::AccessToken.secret_key
          )
        }

        if Configuration::Jwt::RefreshToken.algorithm.present?
          result[:refresh_token] = AuthRails.jwt_strategy.gen_token(
            resource: resource,
            payload: token_payload,
            exp: Configuration::Jwt::RefreshToken.exp.to_i,
            algorithm: Configuration::Jwt::RefreshToken.algorithm,
            secret_key: Configuration::Jwt::RefreshToken.secret_key
          )

          cookie_http_only(result[:refresh_token])
        end

        result
      end

      def cookie_http_only(refresh_token)
        return if Configuration::Jwt::RefreshToken.http_only.blank?

        cookies[Configuration::Jwt::RefreshToken.cookie_key.to_sym || :ref_tok] = {
          httponly: true,
          value: refresh_token,
          secure: Rails.env.production?,
          expires: Time.at(Configuration::Jwt::RefreshToken.exp).to_datetime
        }
      end
    end
  end
end
