class CreateIssues < ActiveRecord::Migration[6.1]
  def change
    create_table :issues do |t|
      t.string :name
      t.string :ancestry
      t.integer :project_id
      t.integer :user_id
      t.text :description
      t.integer :level

      t.timestamps
    end
  end
end
