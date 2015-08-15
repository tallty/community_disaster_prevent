class ChangeReferenceFromDisasterPosition < ActiveRecord::Migration
  def change
    remove_reference :disasters, :disaster_positions
    add_reference :disasters, :disaster_position, index: true
  end
end
