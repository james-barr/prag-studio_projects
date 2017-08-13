class AddMoreFieldsToProjects < ActiveRecord::Migration[5.1]
  def change
    add_column :projects, :team_members, :string
    add_column :projects, :image_file_name, :string
  end
end
