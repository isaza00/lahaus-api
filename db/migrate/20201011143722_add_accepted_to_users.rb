class AddAcceptedToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :photos, :accepted, :boolean
  end
end
