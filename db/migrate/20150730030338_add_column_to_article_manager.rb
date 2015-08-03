class AddColumnToArticleManager < ActiveRecord::Migration
  def change
    add_reference :article_managers, :community, index: true
  end
end
