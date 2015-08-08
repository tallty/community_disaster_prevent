class CreateSurveys < ActiveRecord::Migration
  def change
    create_table :surveys do |t|
      t.string :s_title
      t.string :s_digest
      t.string :s_author
      t.references :community, index: true

      t.timestamps null: false
    end
  end
end
