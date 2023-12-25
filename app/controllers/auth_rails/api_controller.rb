# frozen_string_literal: true

module AuthRails
  class ApiController < ActionController::API
    include ActionController::Cookies
    include AuthRails::Authentication
  end
end
