class AddAttachmentDataToDisasterPictures < ActiveRecord::Migration
  def self.up
    change_table :disaster_pictures do |t|
      t.attachment :data
    end
  end

  def self.down
    remove_attachment :disaster_pictures, :data
  end
end
