json.extract! inventory, :id, :item, :serial_number, :location, :warranty_ends, :active, :created_at, :updated_at
json.url inventory_url(inventory, format: :json)
