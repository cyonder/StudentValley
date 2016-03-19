class CreateRoommates < ActiveRecord::Migration
  def change
    create_table :roommates do |t|
      t.integer :seller_id
      t.string :title
      t.text :description
      t.integer :street_number
      t.string :street_name
      t.string :postal_code
      t.string :city
      t.string :province
      t.string :price
      t.string :available_date
      t.boolean :private_room, default: false
      t.boolean :private_bathroom, default: false
      t.string :laundry_room
      t.boolean :pet_friendly, default: false
      t.string :parking_spot

      t.timestamps null: false
    end
  end
end
