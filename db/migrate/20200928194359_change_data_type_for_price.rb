class ChangeDataTypeForPrice < ActiveRecord::Migration[6.0]
  def change
    change_column :properties, :price, :string
  end
end
