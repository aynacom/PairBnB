class AddColumnsToTables < ActiveRecord::Migration[5.1]
  def change
  	add_column :users, :gender,:string
  	add_column :users,:phone,:string
  	add_column :users,:country,:string
  	add_column :users,:birthdate,:date

  	add_column :listings, :name,:string
  	add_column :listings,:place_type,:string
  	add_column :listings,:property_type,:string
  	add_column :listings,:room_number,:string
  	add_column :listings,:bed_number,:string
  	add_column :listings, :guest_number,:string
  	add_column :listings,:country,:string
  	add_column :listings,:state,:string
  	add_column :listings,:city,:string
  	add_column :listings,:zipcode,:string
  	add_column :listings,:description,:text

  end
end
