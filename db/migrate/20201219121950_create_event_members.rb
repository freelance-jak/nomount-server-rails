# frozen_string_literal: true

class CreateEventMembers < ActiveRecord::Migration[6.0]
  def change
    create_table :event_members do |t|
      t.references :event, null: false, foreign_key: true
      t.references :member, null: false, foreign_key: true
      t.string :status, null: false, default: "wait"

      t.timestamps
    end
  end
end
