class ChangePriceColumnInProducts < ActiveRecord::Migration
  def up
    change_column :products, :price, :decimal, precision: 10, scale: 2
  end

  def down
  end
end
