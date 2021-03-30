class CreateInventories < ActiveRecord::Migration[5.2]
  def change
    create_table :inventories do |t|
      t.string :item
      t.string :serial_number
      t.string :location
      t.date :warranty_ends
      t.boolean :active, default: true

      t.timestamps
    end
  end
end
