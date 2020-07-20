class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :author
      t.string :text
      t.date :date
      t.references :video, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
