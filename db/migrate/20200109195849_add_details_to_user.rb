class AddDetailsToUser < ActiveRecord::Migration[5.2]
  def up
    add_column :users, :fname, :string
    add_column :users, :lname, :string
    add_column :users, :address, :string
    add_column :users, :address2, :string
    add_column :users, :city, :string
    add_column :users, :state, :string
    add_column :users, :zip, :string
    add_column :users, :telephone, :string
    add_column :users, :sms_ok, :boolean, default: false
  end

  def down
    remove_column :users, :fname
    remove_column :users, :lname
    remove_column :users, :address
    remove_column :users, :address2
    remove_column :users, :city
    remove_column :users, :state
    remove_column :users, :zip
    remove_column :users, :telephone
    addremove_column_column :users, :sms_ok
  end
end
