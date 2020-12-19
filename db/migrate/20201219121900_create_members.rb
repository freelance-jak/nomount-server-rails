# frozen_string_literal: true

class CreateMembers < ActiveRecord::Migration[6.0]
  def change
    create_table :members do |t|
      t.string :connpass_account, null: false
      t.string :name, null: false

      t.timestamps
    end
    add_index :members, :connpass_account, unique: true
  end
end
