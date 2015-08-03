class AddColumnToMessageProcessor < ActiveRecord::Migration
  def change
    add_column :message_processors, :message_type, :string
  end
end
