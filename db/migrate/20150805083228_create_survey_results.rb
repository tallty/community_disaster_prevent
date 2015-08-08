class CreateSurveyResults < ActiveRecord::Migration
  def change
    create_table :survey_results do |t|
      t.string :q_result
      t.references :survey, index: true
      t.references :subscriber, index: true
      t.timestamps null: false
    end
  end
end
