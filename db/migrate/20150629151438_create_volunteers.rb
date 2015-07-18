class CreateVolunteers < ActiveRecord::Migration
  def change
    create_table :volunteers do |t|
      t.string :name
      t.string :tel
      t.string :commun
      t.string :neighborhood

      t.references :subscriber, index: true
      t.references :communitie, index: true
      t.timestamps null: false
    end
    add_index :volunteers, :tel
  end
end
