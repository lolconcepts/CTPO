class AddTargetToOffering < ActiveRecord::Migration[5.2]
  def change
    add_column :offerings, :target, :string, :default => "General Gift"
  end
end
