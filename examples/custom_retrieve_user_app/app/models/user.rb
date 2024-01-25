# frozen_string_literal: true

class User < ApplicationRecord
  include AuthRails::Concerns::AllowedTokenStrategy
end
