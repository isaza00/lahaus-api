class AddidcardToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :id_card, :string
  end
end
