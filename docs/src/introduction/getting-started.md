# Getting Started

## Installation

```rb
gem 'auth_rails'
```

## Configuration

AuthRails provides a rake task to generate a configuration file.

```sh
rails g auth_rails
```

It will create a file `config/initializers/auth_rails.rb` with a default configuration.

```rb
# frozen_string_literal: true

AuthRails.configure do |config|
  config.jwt do |jwt|
    jwt.access_token do |access_token|
      access_token.exp = 1.hour.since
      access_token.secret_key = ENV.fetch('JWT_SECRET', '')
    end

    # jwt.strategy = AuthRails::Strategies::AllowedTokenStrategy

    # if you wanna use refresh token
    # uncomment those lines below
    # jwt.refresh_token do |refresh_token|
    #   refresh_token.http_only = true
    #   refresh_token.exp = 1.year.since
    #   refresh_token.algorithm = 'HS256'
    #   refresh_token.cookie_key = :ref_tok
    #   refresh_token.secret_key = ENV.fetch('JWT_SECRET', '')
    # end
  end
end

Rails.application.config.to_prepare do
  AuthRails.configure do |config|
    config.resource_class = User

    # if you wanna use custom error classes
    # uncomment code below
    # config.error_class = AuthError
  end
end
```

> [!NOTE]
> [Check here](/api-reference) to see full API.

### access_token.exp

Expires time for `access_token`.

### access_token.secret_key

Secret key for JWT when creating `access_token`.

### config.resource_class

User model in your application. Usually is `User`.

## Modify User model

AuthRails will use method `authenticate` from `has_secure_password` as default.

```rb
# app/models/user.rb
class User < ApplicationRecord
  has_secure_password
end
```

## Use AuthRails' default controller

Define a route for sign in controller.

```rb
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
```

Create a controller that is inherited from default controller.

```rb
# frozen_string_literal: true

module Api
  class AuthController < AuthRails::Api::AuthController
  end
end
```

Now you can sign in using `POST: /api/auth` and refresh the token using `GET: /api/auth/refresh`.

Access current user as anytime using `CurrentAuth.user`.
