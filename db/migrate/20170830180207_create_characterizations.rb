class CreateCharacterizations < ActiveRecord::Migration[5.1]
  def change
    create_table :characterizations do |t|
      t.references :project, foreign_key: true
      t.references :type, foreign_key: true

      t.timestamps
    end
  end
end
