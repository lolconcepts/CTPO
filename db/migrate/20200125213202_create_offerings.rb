class CreateOfferings < ActiveRecord::Migration[5.2]
  def change
    create_table :offerings do |t|
      t.string :stripe_id
      t.string :uid
      t.string :amount

      t.timestamps
    end
  end
end
