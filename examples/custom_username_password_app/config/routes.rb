# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :api do
    resource :auth, path: 'auth', controller: 'auth', only: %i[create] do
      collection do
        get :refresh
      end
    end
  end
end
