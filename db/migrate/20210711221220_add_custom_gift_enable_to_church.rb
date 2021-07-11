class AddCustomGiftEnableToChurch < ActiveRecord::Migration[5.2]
  def change
    add_column :churches, :customgiftenabled, :bool, default: false
  end
end
