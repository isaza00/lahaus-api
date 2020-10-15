class ChangeIndexForUserIdInProperties < ActiveRecord::Migration[6.0]
  def change
    remove_index :properties, :user_id
    add_index :properties, :user_id
  end
end
