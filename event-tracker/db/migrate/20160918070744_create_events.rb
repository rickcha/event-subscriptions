class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.string :title
      t.text :description
      t.string :address
      t.string :city
      t.string :province
      t.string :postalcode
      t.string :country
      t.datetime :datetime
      t.integer :event_type
      t.float :latitude
      t.float :longitude

      t.timestamps null: false
    end
  end
end
