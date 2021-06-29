class CreateSkills < ActiveRecord::Migration[6.1]
  def change
    create_table :skills do |t|
      t.String :name
      t.String :status
      t.Integer :level

      t.timestamps
    end
  end
end
