# Response your own data structure

Not happy with the default response? Do not worry, you can override it easily.

## Sign In Response

To custom your sign in response data structure, you should override the method `respond_to_create`.

```rb
# frozen_string_literal: true

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

If your response for refresh token action is the same, make this as its alias.

```rb
alias respond_to_refresh respond_to_create
```

## Refresh Response

To custom your refresh action response data structure, you should override the method `respond_to_refresh`.

```rb
# frozen_string_literal: true

module Api
  class AuthController < AuthRails::Api::AuthController
    private

    def respond_to_refresh(data)
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

In case your sign in action's response is the same, make this as its alias.

```rb
alias respond_to_create respond_to_refresh
```
