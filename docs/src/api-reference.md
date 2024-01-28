# API Reference

All features of AuthRails.

## Configuration

### dig_params

- Type: `Proc`
- Default: `nil`
- Required: `false`

Method to extract `identifier` for [`retrieve_resource`](/api-reference.html#retrieve-resource).

```rb
# frozen_string_literal: true

Rails.application.config.to_prepare do
  AuthRails.configure do |config|
    config.resource_class = User
    config.identifier_name = :username
    config.dig_params = ->(params) { params[:identifier] }

    config.retrieve_resource = lambda { |identifier|
      User.where(email: identifier)
          .or(User.where(username: identifier))
          .first
    }
  end
end
```

`identifier_name` will be used for JWT's payload's `sub` if you have `dig_params` configuration.

### error_class

- Type: `Class`
- Default: `nil`
- Required: `false`

Custom error class for AuthRails.

Whenever AuthRails raises error, it will raise your error.

```rb
# frozen_string_literal: true

Rails.application.config.to_prepare do
  AuthRails.configure do |config|
    config.resource_class = User
    config.error_class = YourError
  end
end
```

### authenticate

- Type: `Proc`
- Default: `nil`
- Required: `false`

Custom method to validate your user password. If not provided, you must add `has_secure_password` to your model. Or create a method called `authenticate` to do the validation for your model. Or else it will raise error.

```rb
# frozen_string_literal: true

Rails.application.config.to_prepare do
  AuthRails.configure do |config|
    config.resource_class = User
    config.authenticate = ->(resource, password) { resource.password == password }
  end
end
```

### resource_class

- Type: `Class`
- Default: `nil`
- Required: `true`

Your own class to do sign in. Usually it is `User`.

```rb
# frozen_string_literal: true

Rails.application.config.to_prepare do
  AuthRails.configure do |config|
    config.resource_class = User
  end
end
```

### identifier_name

- Type: `String` | `Symbol`
- Default: `:email`
- Required: `false`

Your resource class identifier.

```rb
# frozen_string_literal: true

Rails.application.config.to_prepare do
  AuthRails.configure do |config|
    config.resource_class = User
    config.identifier_name = :username
  end
end
```

### retrieve_resource

- Type: `Proc`
- Default: `nil`
- Required: `false`

Method to custom how to get resource when your project requires a complex logic.

```rb
# frozen_string_literal: true

Rails.application.config.to_prepare do
  AuthRails.configure do |config|
    config.resource_class = User
    config.identifier_name = :username
    config.dig_params = ->(params) { params[:identifier] }

    config.retrieve_resource = lambda { |identifier|
      User.where(email: identifier)
          .or(User.where(username: identifier))
          .first
    }
  end
end
```

#### config.identifier_name

This is used for JWT's payload's `sub`.

#### config.dig_params

This extracts `identifier` from parameters for the provided method.

## JWT Configuration

### jwt.strategy

- Type: `Class`
- Default: `AuthRails::Strategies::BaseStrategy`
- Required: `false`

Specify which strategy to handle `refresh_token`.

```rb
# frozen_string_literal: true

class YourOwnStrategy < AuthRails::Strategies::BaseStrategy
end

AuthRails.configure do |config|
  config.jwt do |jwt|
    jwt.strategy = YourOwnStrategy
  end
end
```

## JWT Access Token Configuration

### access_token.exp

- Type: `ActiveSupport::TimeWithZone`
- Default: `nil`
- Required: `false`

Expiry time for `access_token`.

```rb
# frozen_string_literal: true

AuthRails.configure do |config|
  config.jwt do |jwt|
    jwt.strategy = AuthRails::Strategies::AllowedTokenStrategy

    jwt.access_token do |access_token|
      access_token.exp = 1.hour.since
    end
  end
end
```

### access_token.algorithm

- Type: `string`
- Default: `HS256`
- Required: `false`

Algorithm for JWT generator.

```rb
# frozen_string_literal: true

AuthRails.configure do |config|
  config.jwt do |jwt|
    jwt.strategy = AuthRails::Strategies::AllowedTokenStrategy

    jwt.access_token do |access_token|
      access_token.exp = 1.hour.since
      access_token.algorithm = 'HS384'
    end
  end
end
```

### access_token.secret_key

- Type: `string`
- Default: `nil`
- Required: `false`

Secret token for JWT generator.

```rb
# frozen_string_literal: true

AuthRails.configure do |config|
  config.jwt do |jwt|
    jwt.strategy = AuthRails::Strategies::AllowedTokenStrategy

    jwt.access_token do |access_token|
      access_token.exp = 1.hour.since
      access_token.algorithm = 'HS384'
      access_token.secret_key = 'My Secret Key'
    end
  end
end
```

## JWT Refresh Token Configuration

### refresh_token.exp

- Type: `ActiveSupport::TimeWithZone`
- Default: `nil`
- Required: `false`

Expiry time for `refresh_token`.

```rb
# frozen_string_literal: true

AuthRails.configure do |config|
  config.jwt do |jwt|
    jwt.strategy = AuthRails::Strategies::AllowedTokenStrategy

    jwt.refresh_token do |refresh_token|
      refresh_token.exp = 1.hour.since
    end
  end
end
```

### refresh_token.algorithm

- Type: `string`
- Default: `nil`
- Required: `false`

Algorithm for JWT generator.

```rb
# frozen_string_literal: true

AuthRails.configure do |config|
  config.jwt do |jwt|
    jwt.strategy = AuthRails::Strategies::AllowedTokenStrategy

    jwt.refresh_token do |refresh_token|
      refresh_token.exp = 1.hour.since
      refresh_token.algorithm = 'HS384'
    end
  end
end
```

### refresh_token.secret_key

- Type: `string`
- Default: `nil`
- Required: `false`

Secret token for JWT generator.

```rb
# frozen_string_literal: true

AuthRails.configure do |config|
  config.jwt do |jwt|
    jwt.strategy = AuthRails::Strategies::AllowedTokenStrategy

    jwt.refresh_token do |refresh_token|
      refresh_token.exp = 1.hour.since
      refresh_token.algorithm = 'HS384'
      refresh_token.secret_key = 'My Secret Key'
    end
  end
end
```

### refresh_token.http_only

- Type: `boolean`
- Default: `false`
- Required: `false`

If true, before respond the `refresh_token`, AuthRails will set `refresh_token` as `httpOnly` cookie.

Cookie key will be `ref_tok`.

```rb
# frozen_string_literal: true

AuthRails.configure do |config|
  config.jwt do |jwt|
    jwt.strategy = AuthRails::Strategies::AllowedTokenStrategy

    jwt.refresh_token do |refresh_token|
      refresh_token.http_only = true
      refresh_token.exp = 1.hour.since
      refresh_token.algorithm = 'HS384'
      refresh_token.secret_key = 'My Secret Key'
    end
  end
end
```

### refresh_token.cookie_key

- Type: `String` | `Symbol`
- Default: `false`
- Required: `false`

Set cookie key for AuthRails when [`refresh_token.http_only`](/api-reference.html#refresh-token-http-only) is enabled.

```rb
# frozen_string_literal: true

AuthRails.configure do |config|
  config.jwt do |jwt|
    jwt.strategy = AuthRails::Strategies::AllowedTokenStrategy

    jwt.refresh_token do |refresh_token|
      refresh_token.http_only = true
      refresh_token.exp = 1.hour.since
      refresh_token.algorithm = 'HS384'
      refresh_token.cookie_key = :my_ref_tok
      refresh_token.secret_key = 'My Secret Key'
    end
  end
end
```
