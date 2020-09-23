class AddThankYouToChurch < ActiveRecord::Migration[5.2]
  def change
  	add_column :churches, :thankyou, :string, :default => "Thank you so much for your generous gift."
  end
end
