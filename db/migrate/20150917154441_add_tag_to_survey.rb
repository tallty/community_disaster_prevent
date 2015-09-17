class AddTagToSurvey < ActiveRecord::Migration
  def change
    add_column :surveys, :tag, :string
  end
end
