class CreateMessageProcessors < ActiveRecord::Migration
  def change
    create_table :message_processors do |t|
      t.string :event_key
      t.string :process_class_name # 处理的对象
      t.string :process_method # 处理的方法
      t.string :result_type #返回结果类型

      t.timestamps null: false
    end
    add_index :message_processors, :process_class_name
  end
end
