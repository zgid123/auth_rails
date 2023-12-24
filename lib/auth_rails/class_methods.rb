# frozen_string_literal: true

module AuthRails
  class << self
    def configure
      yield Config
    end
  end
end
