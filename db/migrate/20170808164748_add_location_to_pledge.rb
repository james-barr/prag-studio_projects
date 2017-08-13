class AddLocationToPledge < ActiveRecord::Migration[5.1]
  def change
    add_column :pledges, :location, :string
  end
end
