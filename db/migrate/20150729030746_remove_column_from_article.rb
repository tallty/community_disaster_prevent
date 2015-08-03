class RemoveColumnFromArticle < ActiveRecord::Migration
  def up
    remove_column :articles, :event_key
    remove_column :articles, :is_show
    remove_column :articles, :keywords
    remove_column :articles, :show_cover_pic
    remove_column :articles, :article_type
  end

  def down
    add_column :articles, :event_key, :string
    add_column :articles, :is_show, :string
    add_column :articles, :keywords, :string
    add_column :articles, :show_cover_pic, :integer
    add_column :articles, :article_type, :string
  end
end
