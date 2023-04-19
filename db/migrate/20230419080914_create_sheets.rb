class CreateSheets < ActiveRecord::Migration[6.1]
  def change
    create_table :sheets do |t|
      t.string :title, null:  false
      t.text :content, null: false
      t.integer :genre_id, null: false
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
