class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.string :title
      t.references :category, index: true, foreign_key: true
      t.string :youtube_url
      t.string :youtube_embed_id

      t.timestamps null: false
    end
  end
end
