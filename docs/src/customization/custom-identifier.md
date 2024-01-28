# Custom your own identifier for your model

My model does not use `email` as its `identifier`, how to make AuthRails works with my model?

Tell AuthRails what it is.

```rb
# frozen_string_literal: true

Rails.application.config.to_prepare do
  AuthRails.configure do |config|
    config.resource_class = User
    config.identifier_name = :username
  end
end
```
