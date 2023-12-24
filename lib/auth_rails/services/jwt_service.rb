# frozen_string_literal: true

module AuthRails
  module Services
    class JwtService
      class << self
        def gen_token(payload:, exp: nil)
          exp ||= Configuration::Jwt.exp.to_i

          JWT.encode(payload, jwt_secret, algo, { exp: exp.to_i })
        end

        def verify_token(token:)
          JWT.decode(token, jwt_secret, true, { algorithm: algo })[0]
        end

        private

        def jwt_secret
          @jwt_secret ||= Configuration::Jwt.secret_key
        end

        def algo
          @algo ||= Configuration::Jwt.algorithm || 'HS256'
        end
      end
    end
  end
end
