class RemoveProjectIdFromIssue < ActiveRecord::Migration[6.1]
  def change
    remove_column :issues, :project_id, :integer
  end
end
