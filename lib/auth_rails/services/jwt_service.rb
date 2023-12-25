# frozen_string_literal: true

module AuthRails
  module Services
    class JwtService
      class << self
        def gen_token(payload:, exp: nil, secret_key: nil, algorithm: nil, jti: nil)
          exp ||= Configuration::Jwt::AccessToken.exp.to_i

          JWT.encode(
            (payload || {}).merge(jti: jti || SecureRandom.hex(20)),
            secret_key,
            algo(algorithm),
            {
              exp: exp.to_i
            }
          )
        end

        def verify_token(token:, secret_key: nil, algorithm: nil)
          JWT.decode(
            token,
            secret_key,
            true,
            {
              algorithm: algo(algorithm)
            }
          )[0].deep_symbolize_keys
        rescue StandardError
          {}
        end

        private

        def algo(algorithm)
          algorithm || Configuration::Jwt::AccessToken.algorithm
        end
      end
    end
  end
end
