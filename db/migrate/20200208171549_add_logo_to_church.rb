class AddLogoToChurch < ActiveRecord::Migration[5.2]
  def up
  	add_column :churches, :avatar, :string
  end
  def down
  	remove_column :churches, :avatar
  end
end
