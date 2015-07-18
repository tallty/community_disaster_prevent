class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :event_key
      t.string :title
      t.string :author
      t.string :content_source_url
      t.text :content
      t.string :digest
      t.integer :show_cover_pic
      t.string :article_type
      t.string :is_show
      t.string :thumb_media_url
      t.string :keywords
      t.timestamps null: false
    end
    add_index :articles, :title
    add_index :articles, :article_type
  end
end
