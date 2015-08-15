class RemoveReferenceFormDisaster < ActiveRecord::Migration
  def change
    remove_reference :disasters, :disaster_picture, index: true
    add_reference :disaster_pictures, :disaster, index: true
  end
end
