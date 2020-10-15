class AddColumnToPhotos < ActiveRecord::Migration[6.0]
  def change
    add_column :photos, :accepted_lum, :boolean
    rename_column :photos, :accepted, :accepted_foc
  end
end
