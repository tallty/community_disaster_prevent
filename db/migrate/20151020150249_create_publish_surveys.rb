class CreatePublishSurveys < ActiveRecord::Migration
  def change
    create_table :publish_surveys do |t|
      t.references :community, index: true
      t.references :survey, index: true
      t.integer :status
      
      t.timestamps null: false
    end
  end
end
