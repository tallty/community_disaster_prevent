class CreateSubscribers < ActiveRecord::Migration
  def change
    create_table :subscribers do |t|
      t.string :openid
      t.integer :sex
      t.string :city
      t.string :province
      t.string :country
      t.string :headimgurl

      t.timestamps null: false
    end
    add_index :subscribers, :openid
  end
end
