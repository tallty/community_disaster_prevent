class RemoveColumnFromDisasterPicture < ActiveRecord::Migration
  def change
    remove_column :disaster_pictures, :file_name, :string
    remove_column :disaster_pictures, :url, :string
    remove_column :disaster_pictures, :local_path, :string
  end
end
