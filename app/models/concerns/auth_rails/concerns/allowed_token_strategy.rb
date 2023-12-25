# frozen_string_literal: true

module AuthRails
  module Concerns
    module AllowedTokenStrategy
      extend ActiveSupport::Concern

      included do
        has_many :allowed_tokens, dependent: :destroy
      end
    end
  end
end
