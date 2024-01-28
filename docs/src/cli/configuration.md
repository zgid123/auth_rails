# CLI to generate Configuration

## Default Option

```sh
rails g auth_rails
```

This will create a default configuration for AuthRails.

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

## Strategy Option

```sh
rails g auth_rails --strategy allowed_token
```

This will create a configuration and enable strategy `AuthRails::Strategies::AlloedTokenStrategy` as default.

```rb
# frozen_string_literal: true

AuthRails.configure do |config|
  config.jwt do |jwt|
    jwt.access_token do |access_token|
      access_token.exp = 1.hour.since
      access_token.secret_key = ENV.fetch('JWT_SECRET', '')
    end

    jwt.strategy = AuthRails::Strategies::AllowedTokenStrategy

    # remember uncomment those ones
    jwt.refresh_token do |refresh_token|
      refresh_token.http_only = true
      refresh_token.exp = 1.year.since
      refresh_token.algorithm = 'HS256'
      refresh_token.cookie_key = :ref_tok
      refresh_token.secret_key = ENV.fetch('JWT_SECRET', '')
    end
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

You must modify User model to make this works.

```rb
# app/models/user.rb
# frozen_string_literal: true

class User < ApplicationRecord
  include AuthRails::Concerns::AllowedTokenStrategy

  has_secure_password
end
```

## Model Option

```sh
rails g auth_rails --model CustomUser
```

This will create a configuration with the `resource_class` as `CustomUser`.

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
    config.resource_class = CustomUser

    # if you wanna use custom error classes
    # uncomment code below
    # config.error_class = AuthError
  end
end
```

Remember to modify the `CustomUser` class.

```rb
# frozen_string_literal: true

class CustomUser < ApplicationRecord
  has_secure_password
end
```
