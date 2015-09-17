class AddQIndexToSurveyResult < ActiveRecord::Migration
  def change
    add_column :survey_results, :q_index, :integer
  end
end
