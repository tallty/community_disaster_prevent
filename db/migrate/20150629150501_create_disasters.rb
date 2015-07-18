class CreateDisasters < ActiveRecord::Migration
  def change
    create_table :disasters do |t|
      t.datetime :occur_time # 发生时间
      t.string :disaster_type # 灾情类型
      t.text :explain # 说明

      t.references :subscriber, index: true
      t.references :disaster_positions, index: true
      t.references :disaster_picture, index: true

      t.timestamps null: false
    end

    add_index :disasters, :occur_time
  end
end
