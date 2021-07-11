class AddSpecialGiftToChurch < ActiveRecord::Migration[5.2]
  def change
    add_column :churches, :specialgiftamount, :string
    add_column :churches, :specialgifttext, :string
  end
end
