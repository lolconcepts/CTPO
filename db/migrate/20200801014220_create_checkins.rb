class CreateCheckins < ActiveRecord::Migration[5.2]
  def change
    create_table :checkins do |t|
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
