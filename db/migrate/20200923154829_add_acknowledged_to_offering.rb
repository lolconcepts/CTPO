class AddAcknowledgedToOffering < ActiveRecord::Migration[5.2]
  def change
    add_column :offerings, :acknowledge, :boolean, default: false
  end
end
