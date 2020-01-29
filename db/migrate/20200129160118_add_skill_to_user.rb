class AddSkillToUser < ActiveRecord::Migration[5.2]
  def up
  	add_column :users, :skill, :string
  end
  def down
  	remove_column :users, :skill
  end
end
