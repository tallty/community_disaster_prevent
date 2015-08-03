class RemoveColumnFromVolunteer < ActiveRecord::Migration
  def change
    add_reference :volunteers, :subscriber, index: true
  end

end
