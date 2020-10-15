class ChangeVariableTypeFromProperties < ActiveRecord::Migration[6.0]
  def change
    rename_column :properties, :type, :built_type
  end
end
