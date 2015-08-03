class AddColumnToSubscriber < ActiveRecord::Migration
  def change
    add_reference :subscribers, :community, index: true
    remove_reference :volunteers, :community
  end
end
