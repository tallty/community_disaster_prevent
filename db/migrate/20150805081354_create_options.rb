class CreateOptions < ActiveRecord::Migration
  def change
    create_table :options do |t|
      t.string :option_title
      t.references :question, index: true

      t.timestamps null: false
    end
  end
end
