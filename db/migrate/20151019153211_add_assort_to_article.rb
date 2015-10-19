class AddAssortToArticle < ActiveRecord::Migration
  def change
    add_column :articles, :assort, :string
  end
end
