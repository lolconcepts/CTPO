class AddShortDateToCheckin < ActiveRecord::Migration[5.2]
  def change
    add_column :checkins, :short_date, :string
  end
end
