# frozen_string_literal: true

module AuthRails
  module Strategies
    class BaseStrategy
      class << self
        def retrieve_resource(payload:)
          symbolized_payload = payload.symbolize_keys

          AuthRails.resource_class
                   .find_by(AuthRails.identifier_name => symbolized_payload[:sub])
        end

        def gen_token(payload:, exp: nil, secret_key: nil, algorithm: nil, jti: nil, **)
          Services::JwtService.gen_token(
            exp: exp,
            jti: jti,
            payload: payload,
            algorithm: algorithm,
            secret_key: secret_key
          )
        end
      end
    end
  end
end
