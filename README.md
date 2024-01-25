Simple authentication for rails.

# Installation

```sh
gem 'auth_rails'
```

# CLI

- init `auth_rails`

```sh
rails g auth_rails
```

- init `auth_rails` with strategy

```sh
rails g auth_rails --strategy allowed_token
```

- create migration for `allowed_token` strategy

```sh
rails g auth_rails:migration --strategy allowed_token
```

- if your model is not User

```sh
rails g auth_rails:migration --strategy allowed_token --model CustomUser
```

# Configuration

- User model must have `has_secure_password`

```rb
# app/models/user.rb
class User < ApplicationRecord
  has_secure_password
end
```

```rb
# config/initializers/auth_rails.rb

AuthRails.configure do |config|
  config.jwt do |jwt|
    jwt.strategy = AuthRails::Strategies::AllowedTokenStrategy # default is AuthRails::Strategies::BaseStrategy

    jwt.access_token do |access_token|
      access_token.exp = 1.hour.since # optional
      access_token.algorithm = 'HS256' # optional, default is HS256
      access_token.secret_key = ENV.fetch('JWT_SECRET', 'secret_key') # optional
    end

    jwt.refresh_token do |refresh_token|
      refresh_token.http_only = true # optional
      refresh_token.exp = 1.year.since # optional
      refresh_token.algorithm = 'HS256' # optional, must provide if project supports refresh token
      refresh_token.cookie_key = :project_ref_tok # optional
      refresh_token.secret_key = ENV.fetch('JWT_SECRET', 'secret_key') # optional
    end
  end
end

Rails.application.config.to_prepare do
  AuthRails.configure do |config|
    config.resource_class = User # required
    config.error_class = ProjectError # optional
  end
end
```

# Usage

```rb
# config/routes.rb

Rails.application.routes.draw do
  namespace :api do
    resource :auth, path: 'auth', controller: 'auth', only: %i[create] do
      collection do
        get :refresh
      end
    end
  end
end
```

```rb
# app/controllers/application_controller.rb

class ApplicationController < ActionController::API
  # to include helpers for authenticating using access_token
  include AuthRails::Authentication

  # this action will assign user to CurrentAuth.user if valid token
  # else raise error: AuthRails::Error or custom error in configuration
  before_action :authenticate_user!
end
```

```rb
# app/controllers/api/auth_controller.rb

module Api
  class AuthController < AuthRails::Api::AuthController
  end
end
```

- If you want to support refresh token

```rb
# app/models/user.rb

class User < ApplicationRecord
  include AuthRails::Concerns::AllowedTokenStrategy

  has_secure_password
end
```

# Customize

- Custom Strategy

```rb
class CustomStrategy < AuthRails::Strategies::BaseStrategy
  class << self
    # this is for getting user/resource using payload from access_token
    def retrieve_resource(payload:)
      super
    end

    # this is for generating refresh token
    # if you do not support refresh token, can ignore this one
    def gen_token(resource:, payload:, exp: nil, secret_key: nil, algorithm: nil)
      super
    end
  end
end
```

- Custom response for controller

```rb
module Api
  class AuthController < AuthRails::Api::AuthController
    private

    def respond_to_create(data)
      render json: {
        profile: CurrentAuth.user,
        tokens: {
          auth_token: data[:access_token],
          refresh_token: data[:refresh_token]
        }
      }
    end
  end
end
```

- In case your identifier is not email

```rb
Rails.application.config.to_prepare do
  AuthRails.configure do |config|
    config.resource_class = User # required
    config.identifier_name = :username # must be string or symbol, default is email
  end
end
```

- If you have a custom method to validate password

```rb
Rails.application.config.to_prepare do
  AuthRails.configure do |config|
    config.resource_class = User # required
    config.identifier_name = :username # must be string or symbol, default is email
    config.authenticate = ->(resource, password) { resource.password == password } # must be a proc, validate password
  end
end
```

- Sometimes, you have a complex logic to get the user

```rb
Rails.application.config.to_prepare do
  AuthRails.configure do |config|
    config.resource_class = User # required
    config.identifier_name = :username # this one is sub in jwt
    config.dig_params = ->(params) { params[:identifier] } # must be a proc, how to get identifier from params

    # how to get user from identifier
    # identifier default is params[<identifier_name>]
    # or extract from dig_params
    config.retrieve_resource = lambda { |identifier|
      User.where(email: identifier)
          .or(User.where(username: identifier))
          .first
    }
  end
end
```

# Strategy list

- allowed_token

# License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
