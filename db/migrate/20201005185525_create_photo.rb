class CreatePhoto < ActiveRecord::Migration[6.0]
  def change
    create_table :photos do |t|
      t.string :url
      t.belongs_to :property, foreign_key: true
      t.timestamps
    end
  end
end
