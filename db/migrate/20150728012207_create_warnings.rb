class CreateWarnings < ActiveRecord::Migration
  def change
    create_table :warnings do |t|
      t.datetime :publish_time
      t.string :warning_type
      t.string :level
      t.text :content

      t.references :community, index: true
      t.timestamps null: false
    end
    add_index :warnings, :publish_time
    add_index :warnings, :warning_type
  end
end
