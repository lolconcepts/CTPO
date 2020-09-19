class AddCalendlyToChurch < ActiveRecord::Migration[5.2]
  def change
    add_column :churches, :calendly_url, :string
  end
end
