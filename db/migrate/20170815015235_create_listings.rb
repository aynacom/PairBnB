class CreateListings < ActiveRecord::Migration[5.1]
  def change
    create_table :listings do |t|
      t.text :address
      t.float :price_per_night
      t.text :tags
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
