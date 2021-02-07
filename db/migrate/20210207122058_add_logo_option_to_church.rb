class AddLogoOptionToChurch < ActiveRecord::Migration[5.2]
  def change
    add_column :churches, :logo, :bool, :default => false
  end
end
