class AddItemIndexToQuestion < ActiveRecord::Migration
  def change
    add_column :questions, :item_index, :integer, :default => 0
  end
end
