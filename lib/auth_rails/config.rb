# frozen_string_literal: true

module AuthRails
  class Config
    class << self
      def jwt
        yield Configuration::Jwt
      end
    end
  end
end
