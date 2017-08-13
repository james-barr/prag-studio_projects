class CreatePledges < ActiveRecord::Migration[5.1]
  def change
    create_table :pledges do |t|
      t.string :name
      t.string :email
      t.text :comment
      t.integer :pledge
      t.references :project, foreign_key: true

      t.timestamps
    end
  end
end
