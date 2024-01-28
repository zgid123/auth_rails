# CLI to generate Migration

This CLI always need to provide a strategy option to know which migration file should be created.

## Default Option

```sh
rails g auth_rails:migration --strategy allowed_token
```

This will create a migration file for `AllowedToken` model.

```rb
# frozen_string_literal: true

class CreateAllowedTokens < ActiveRecord::Migration[7.1]
  def change
    create_table :allowed_tokens do |t|
      t.string :jti, null: false
      t.string :aud
      t.datetime :exp, null: false

      t.timestamps

      t.references :user, foreign_key: { on_delete: :cascade }, null: false

      t.index %i[jti aud]
    end
  end
end
```

## Model Option

```sh
rails g auth_rails:migration --strategy allowed_token --model CustomUser
```

This will create a migration file for `AllowedToken` model and add reference with `CustomUser`.

```rb
# frozen_string_literal: true

class CreateAllowedTokens < ActiveRecord::Migration[7.1]
  def change
    create_table :allowed_tokens do |t|
      t.string :jti, null: false
      t.string :aud
      t.datetime :exp, null: false

      t.timestamps

      t.references :custom_user, foreign_key: { on_delete: :cascade }, null: false

      t.index %i[jti aud]
    end
  end
end
```
