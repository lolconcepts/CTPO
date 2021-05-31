class AddMediaReleaseToUser < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :mediarelease, :bool, default: false
  end
end
