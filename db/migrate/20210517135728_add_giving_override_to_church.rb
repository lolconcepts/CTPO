class AddGivingOverrideToChurch < ActiveRecord::Migration[5.2]
  def change
    add_column :churches, :giving_override, :string
  end
end
