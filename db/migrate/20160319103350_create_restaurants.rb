class CreateRestaurants < ActiveRecord::Migration
  def change
    create_table :restaurants do |t|
      t.string :name
      t.string :name_kana
      t.string :description
      t.string :zip
      t.string :address
      t.boolean :closed

      t.timestamps null: false
    end
  end
end

