class CreateUserSkills < ActiveRecord::Migration[6.1]
  def change
    create_table :user_skills do |t|
      t.Integer :user_id
      t.Integer :skill_id

      t.timestamps
    end
  end
end
