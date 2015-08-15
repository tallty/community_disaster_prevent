class AddAttachmentImageToDisasterPictures < ActiveRecord::Migration
  def self.up
    change_table :disaster_pictures do |t|
      t.attachment :image
    end
  end

  def self.down
    remove_attachment :disaster_pictures, :image
  end
end
