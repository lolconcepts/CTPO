class AddCustomGivingAmountToUser < ActiveRecord::Migration[5.2]
  def up
    add_column :users, :custom_gift, :string
  end
  def down
    remove_column :users, :custom_gift
  end
end
