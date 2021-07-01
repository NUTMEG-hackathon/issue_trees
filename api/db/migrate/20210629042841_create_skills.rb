class CreateSkills < ActiveRecord::Migration[6.1]
  def change
    create_table :skills do |t|
      t.string :name
      t.string :status
      t.integer :level

      t.timestamps
    end
  end
end
