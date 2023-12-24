# frozen_string_literal: true

module AuthRails
  module Configuration
    class Jwt
      class << self
        attr_accessor :secret_key, :algorithm, :exp
      end
    end
  end
end
