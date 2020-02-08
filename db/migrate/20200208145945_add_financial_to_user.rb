class AddFinancialToUser < ActiveRecord::Migration[5.2]
  def up
    add_column :users, :finance, :boolean, default: false
  end
  def down
    remove_column :users, :finance
  end
end
