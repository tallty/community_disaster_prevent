class CreateSendLogs < ActiveRecord::Migration
  def change
    create_table :send_logs do |t|
      t.datetime :start_time
      t.datetime :end_time
      t.string :status
      t.integer :count
      t.string :explain
      t.timestamps null: false
    end
    add_index :send_logs, :start_time
  end
end
