class AddArticleTypeToArticleManager < ActiveRecord::Migration
  def change
    add_column :article_managers, :article_type, :string
  end
end
