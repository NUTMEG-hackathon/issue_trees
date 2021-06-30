class CreateIssueSkills < ActiveRecord::Migration[6.1]
  def change
    create_table :issue_skills do |t|
      t.integer :issue_id
      t.integer :skill_id

      t.timestamps
    end
  end
end
