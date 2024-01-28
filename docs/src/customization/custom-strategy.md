# Use your own strategy

AuthRails provides a base strategy that has two methods: `retrieve_resource` and `gen_token`.

In your project, you may need to handle `refresh_token` in another approach instead of `allowed_token`. You can inherit base strategy and override those two methods to do your own strategy.

```rb
# frozen_string_literal: true

class YourOwnStrategy < AuthRails::Strategies::BaseStrategy
  class << self
    def retrieve_resource(payload:)
      # handle payload and retrieve the user using that payload
    end

    def gen_token(resource:, payload:, exp: nil, secret_key: nil, algorithm: nil, jti: nil)
      # handle how to generate refresh_token
    end
  end
end
```

Next, add this class to the configuration.

```rb
# frozen_string_literal: true

AuthRails.configure do |config|
  config.jwt do |jwt|
    jwt.strategy = YourOwnStrategy
  end
end
```
