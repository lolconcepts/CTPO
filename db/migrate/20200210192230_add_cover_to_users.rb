class AddCoverToUsers < ActiveRecord::Migration[5.2]
  def up
    add_column :users, :cover, :boolean, default: false
  end
   def down
    remove_column :users, :cover
  end
end
