# frozen_string_literal: true

module AuthRails
  module Configuration
    class Jwt
      class << self
        attr_accessor :strategy

        def access_token
          yield AccessToken

          AccessToken.algorithm ||= 'HS256'
        end

        def refresh_token
          yield RefreshToken

          RefreshToken.cookie_key ||= :ref_tok
        end
      end

      class AccessToken
        class << self
          attr_accessor :exp,
                        :algorithm,
                        :secret_key
        end
      end

      class RefreshToken < AccessToken
        class << self
          attr_accessor :http_only, :cookie_key
        end
      end
    end
  end
end
