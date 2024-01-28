# Custom retrieve resource

Sometimes, your logic to retrieve user is too complex. It is not simple `User.find_by(email: identifier)`.

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

## config.identifier_name

This will be used to set to `sub` of JWT's `payload`.

## config.dig_params

To extract `identifier` for the `retrieve_resource` config.

## config.retrieve_resource

This is where you define how to get your resource to do the sign in.
