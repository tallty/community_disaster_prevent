class AddCodeToCommunity < ActiveRecord::Migration
  def change
    add_column :communities, :code, :integer, null: false
    add_index :communities, :code
  end
end
