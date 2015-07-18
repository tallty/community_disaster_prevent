class CreateDisasterPositions < ActiveRecord::Migration
  def change
    create_table :disaster_positions do |t|
      t.float :lon
      t.float :lat
      t.string :address

      t.timestamps null: false
    end
  end
end
