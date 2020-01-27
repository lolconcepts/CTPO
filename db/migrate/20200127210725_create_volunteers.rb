class CreateVolunteers < ActiveRecord::Migration[5.2]
  def up
    create_table :volunteers do |t|
      t.string :name
      t.string :phone
      t.string :email
      t.string :note

      t.timestamps
    end
  end

  def down
  	drop_table :volunteers
  end
end
