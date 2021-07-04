class AddUserIdToProjectUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :project_users, :user_id, :integer
  end
end
