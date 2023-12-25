# frozen_string_literal: true

module AuthRails
  module Strategies
    class AllowedTokenStrategy < BaseStrategy
      class << self
        def retrieve_resource(payload:)
          symbolized_payload = payload.symbolize_keys

          AuthRails.resource_class
                   .joins(:allowed_tokens)
                   .where(allowed_tokens: symbolized_payload.slice(:jti, :aud))
                   .where('allowed_tokens.exp > ?', Time.current)
                   .find_by(email: symbolized_payload[:sub])
        end

        def gen_token(resource:, payload:, exp: nil, secret_key: nil, algorithm: nil)
          jti = SecureRandom.hex(20)

          resource.allowed_tokens
                  .create!(
                    jti: jti,
                    aud: payload[:aud],
                    exp: Time.zone.at(exp)
                  )

          super(
            jti: jti,
            exp: exp,
            payload: payload,
            algorithm: algorithm,
            secret_key: secret_key
          )
        end
      end
    end
  end
end
