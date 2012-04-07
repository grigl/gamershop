class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.text :description, limit: nil
      t.decimal :price
      t.string :platform
      t.string :genre
      t.string :publisher
      t.string :developer

      t.timestamps
    end
  end
end
