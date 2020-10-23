class ChangeNameToRentDesc < ActiveRecord::Migration[6.0]
  def change
    rename_column :properties, :rent_desc, :rent_desition
  end
end
