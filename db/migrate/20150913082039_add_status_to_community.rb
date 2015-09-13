class AddStatusToCommunity < ActiveRecord::Migration
  def change
    add_column :communities, :status, :integer, :default => 0
  end
end
