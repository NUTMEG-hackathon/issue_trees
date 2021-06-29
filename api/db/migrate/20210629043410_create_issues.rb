class CreateIssues < ActiveRecord::Migration[6.1]
  def change
    create_table :issues do |t|
      t.String :name
      t.String :ancestry
      t.Integer :project_id
      t.Integer :user_id
      t.Text :description
      t.Integer :level

      t.timestamps
    end
  end
end
