# Use your own validation password

The method `authenticate` of `has_secure_password` is not good for you? Then make your own validation password.

```rb
# frozen_string_literal: true

Rails.application.config.to_prepare do
  AuthRails.configure do |config|
    config.resource_class = User
    config.authenticate = ->(resource, password) { resource.password == password }
  end
end
```
