# frozen_string_literal: true

class User < ApplicationRecord
  include AuthRails::Concerns::AllowedTokenStrategy

  has_secure_password
end
