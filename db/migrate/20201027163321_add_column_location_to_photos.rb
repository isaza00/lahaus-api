class AddColumnLocationToPhotos < ActiveRecord::Migration[6.0]
  def change
    add_column :photos, :location, :string
  end
end
