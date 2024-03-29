# frozen_string_literal: true

class ApplicationController < ActionController::API
  include AuthRails::Authentication

  before_action :authenticate_user!
end
