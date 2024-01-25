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
