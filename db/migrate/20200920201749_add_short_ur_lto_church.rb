class AddShortUrLtoChurch < ActiveRecord::Migration[5.2]
  def change
  	add_column :churches, :shorturl, :string
  end
end
