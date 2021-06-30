class CreateIssueSkills < ActiveRecord::Migration[6.1]
  def change
    create_table :issue_skills do |t|
      t.Integer :issue_id
      t.Integer :skill_id

      t.timestamps
    end
  end
end
