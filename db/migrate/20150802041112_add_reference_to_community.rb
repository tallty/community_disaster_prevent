class AddReferenceToCommunity < ActiveRecord::Migration
  def change
    add_reference :monitor_stations, :community, index: true
  end
end
