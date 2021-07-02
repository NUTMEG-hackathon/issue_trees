class AddProjectIdToProjectUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :project_users, :project_id, :integer
  end
end
