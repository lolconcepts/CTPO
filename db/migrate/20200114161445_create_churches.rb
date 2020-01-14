class CreateChurches < ActiveRecord::Migration[5.2]
  def change
    create_table :churches do |t|
      t.string :name
      t.string :address
      t.string :city
      t.string :state
      t.string :zip
      t.string :email
      t.string :website
      t.string :telephone
      t.string :service_time
      t.string :pastor
      t.string :pastor_email
      t.string :fb
      t.string :twitter
      t.string :instagram

      t.timestamps
    end
  end
end
