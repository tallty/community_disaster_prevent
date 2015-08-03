class CreateArticleManagers < ActiveRecord::Migration
  def change
    create_table :article_managers do |t|
      t.string :keyword                                                      #关键字
      t.integer :article_index                                            #显示序号
      t.string :page_url

      t.references :article, index: true
      t.timestamps null: false
    end
    add_index :article_managers, :keyword
  end
end
