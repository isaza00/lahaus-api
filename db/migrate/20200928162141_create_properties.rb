class CreateProperties < ActiveRecord::Migration[6.0]
  def change
    create_table :properties do |t|
      #t.text :description
      t.string :project
      t.string :type
      t.integer :price 
      t.string :address
      t.string :apt
      t.string :tower
      t.string :hood
      #t.string :sector
      t.string :city
      #t.string :built_year
      #t.text :finishings
      #t.string :view
      #t.string :extras
      #t.integer :admin
      #t.text :admin_extras
      #t.integer :lodge
      #t.float :built_area
      t.float :private_area
      t.integer :estrato
      #t.text :status
      #t.text :distribution
      #t.boolean :elevator
      #t.string :common_area
      t.integer :beds
      t.integer :baths
      #t.integer :half_baths
      #t.integer :parking
      #t.string :parking_type
      #t.string :storage_room
      #t.integer :appraisal
      #t.integer :predial
      #t.boolean :empty
      #t.boolean :rented
      #t.integer :rented_price
      #t.datetime :rented_until
      #t.boolean :owner_inhabited
      #t.boolen :mortgage
      #t.integer :init_mortgage_cost
      #t.integer :left_mortgage_cost
      #t.string :bank
      #t.string :registration
      #t.string :owner_name_1
      #t.string :owner_name_2
      t.string :contact_1
      #t.string :contact_2
      t.belongs_to :user, index: { unique: true }, foreign_key: true
      t.timestamps
    end
    add_index :properties, :type
    add_index :properties, :price
    add_index :properties, :hood
    add_index :properties, :city
  end
end
