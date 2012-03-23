class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.string :payment_type
      t.string :status
      t.decimal :total_price

      t.timestamps
    end
  end
end
