class ChangePriceColumnInProducts2 < ActiveRecord::Migration
  def up
    change_column :products, :price, :decimal, precision: 8, scale: 2
  end

  def down
  end
end
