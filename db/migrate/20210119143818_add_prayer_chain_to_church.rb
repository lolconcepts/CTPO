class AddPrayerChainToChurch < ActiveRecord::Migration[5.2]
  def change
    add_column :churches, :prayer_chain, :string
  end
end
