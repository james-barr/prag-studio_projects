class CreateProjects < ActiveRecord::Migration[5.1]
  def change
    create_table :projects do |t|
      t.string :name
      t.text :description
      t.decimal :target_pledge_amount

      t.timestamps
    end
  end
end
