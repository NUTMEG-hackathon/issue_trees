class AddClientIdToIssues < ActiveRecord::Migration[6.1]
  def change
    add_column :issues, :client_id, :integer
  end
end
