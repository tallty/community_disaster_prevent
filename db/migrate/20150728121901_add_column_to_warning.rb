class AddColumnToWarning < ActiveRecord::Migration
  def change
    add_column :warnings, :status, :string
  end
end
