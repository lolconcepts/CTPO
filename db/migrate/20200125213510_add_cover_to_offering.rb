class AddCoverToOffering < ActiveRecord::Migration[5.2]
  def up
    add_column :offerings, :cover, :boolean
  end
  def down
  	remove_column :offerings, :cover
  end
  
end
