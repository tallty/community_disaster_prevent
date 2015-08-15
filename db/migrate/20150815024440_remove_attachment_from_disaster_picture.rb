class RemoveAttachmentFromDisasterPicture < ActiveRecord::Migration
  def change
    remove_attachment :disaster_pictures, :data
  end
end
