class CreatePresentations < ActiveRecord::Migration[6.0]
  def change
    create_table :presentations do |t|
      t.string :title, null: false, comment: 'プレゼンのタイトル'
      t.date :presen_date ,null: false, comment: 'プレゼンの発表日'
      t.string :document_path,null: false, comment: '発表資料のURL'
      t.timestamps
    end
  end
end
