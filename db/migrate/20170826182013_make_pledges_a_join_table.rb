class MakePledgesAJoinTable < ActiveRecord::Migration[5.1]
  def up
    Pledge.delete_all
    add_column :pledges, :user_id, :integer
    remove_column :pledges, :name, :string
    remove_column :pledges, :email, :string
  end
  def down
    Pledge.delete_all
    remove_column :pledges, :user_id, :integer
    add_column :pledges, :name, :string
    add_column :pledges, :email, :string
  end
end
