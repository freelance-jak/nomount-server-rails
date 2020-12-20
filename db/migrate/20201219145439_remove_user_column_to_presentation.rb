class RemoveUserColumnToPresentation < ActiveRecord::Migration[6.0]
  def change
    def up
      remove_column :presentations, :user
    end

    def down
      add_column :titles, :users, :bigint
    end
  end
end
