class RemoveContentSourceUrlToArticle < ActiveRecord::Migration
  def up
    remove_column :articles, :content_source_url
  end
  def down
    add_column :articles, :content_source_url, :string
  end
end
