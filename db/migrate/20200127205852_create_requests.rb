class CreateRequests < ActiveRecord::Migration[5.2]
  def up
    create_table :requests do |t|
      t.string :who
      t.text :reason
      t.boolean :call_back
      t.boolean :visit
      t.string :email
      t.string :phone

      t.timestamps
    end
  end

  def down
    drop_table :requests
  end
end
