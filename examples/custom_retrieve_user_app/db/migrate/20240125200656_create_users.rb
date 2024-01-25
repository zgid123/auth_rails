# frozen_string_literal: true

class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :email, null: false, default: '', index: { unique: true }
      t.string :username, null: false, default: '', index: { unique: true }
      t.string :password, null: false, default: ''

      t.timestamps
    end
  end
end
