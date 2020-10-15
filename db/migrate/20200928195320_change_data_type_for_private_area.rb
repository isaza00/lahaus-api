class ChangeDataTypeForPrivateArea < ActiveRecord::Migration[6.0]
  def change
    change_column :properties, :private_area, :string
    change_column :properties, :estrato, :string
  end
end
