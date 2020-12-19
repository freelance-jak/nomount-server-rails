class CreatePresentations < ActiveRecord::Migration[6.0]
  def change
    create_table :presentations do |t|
      t.string :title
      t.bigint :user
      t.date :presen_date
      t.string :document_path

      t.timestamps
    end
  end
end
