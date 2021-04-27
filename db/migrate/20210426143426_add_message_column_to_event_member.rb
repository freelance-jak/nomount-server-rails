class AddMessageColumnToEventMember < ActiveRecord::Migration[6.0]
  def change
    add_column :event_members, :message, :string
  end
end
