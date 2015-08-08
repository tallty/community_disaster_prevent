class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.string :q_title
      t.string :q_type
      t.string :q_digest

      t.references :survey, index: true
      t.timestamps null: false
    end
  end
end
