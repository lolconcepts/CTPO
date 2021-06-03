class AddYTtoChurch < ActiveRecord::Migration[5.2]
  def change
  	add_column :churches, :yt, :string
  end
end
