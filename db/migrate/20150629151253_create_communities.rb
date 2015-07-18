class CreateCommunities < ActiveRecord::Migration
  def change
    create_table :communities do |t|
      t.string :district
      t.string :street
      t.string :c_type
      
      t.timestamps null: false
    end
  end
end
