class AddColumnRentToProperties < ActiveRecord::Migration[6.0]
  def change
    add_column :properties, :rent_desc, :boolean
    remove_column :properties, :mortgage
    add_column :properties, :mortgage, :boolean
  end
end
