class CreateMonitorStations < ActiveRecord::Migration
  def change
    create_table :monitor_stations do |t|
      t.string :station_number
      t.string :station_name
      t.string :station_type

      t.timestamps null: false
    end
  end
end
