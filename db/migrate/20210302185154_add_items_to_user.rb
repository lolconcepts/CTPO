class AddItemsToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :spouse, :string
    add_column :users, :children, :string
    add_column :users, :how_heard, :string
    add_column :users, :professing_member, :bool, :default => false
    add_column :users, :end_of_year_report, :bool, :default => false
  end
end
