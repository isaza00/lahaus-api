class AddColumnToProperties < ActiveRecord::Migration[6.0]
  def change
    add_column :properties, :admon, :string
    add_column :properties, :build_area, :string
    add_column :properties, :social_class, :string
    add_column :properties, :state, :string
    add_column :properties, :elevator, :boolean
    add_column :properties, :common_areas, :string
    add_column :properties, :property_tax, :string
    add_column :properties, :rooms, :string
    add_column :properties, :bathrooms, :string
    add_column :properties, :half_bathrooms, :string
    add_column :properties, :parking_lot, :string
    add_column :properties, :utility_room, :boolean
    add_column :properties, :empty_property, :boolean
    add_column :properties, :inhabitants, :boolean
    add_column :properties, :rent, :string
    add_column :properties, :mortgage, :string
    remove_column :properties, :estrato
    remove_column :properties, :tower
    remove_column :properties, :beds
    remove_column :properties, :baths
    remove_column :properties, :contact_1
  end
end
