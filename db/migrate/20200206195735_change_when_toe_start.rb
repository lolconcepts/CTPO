class ChangeWhenToeStart < ActiveRecord::Migration[5.2]
  def change
  	rename_column :events, :when, :estart
  end
end
