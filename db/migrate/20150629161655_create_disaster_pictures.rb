class CreateDisasterPictures < ActiveRecord::Migration
  def change
    create_table :disaster_pictures do |t|
      t.string :file_name
      t.string :url
      t.string :local_path

      t.timestamps null: false
    end
  end
end
