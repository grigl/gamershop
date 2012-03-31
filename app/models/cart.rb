class Cart < ActiveRecord::Base
  has_many :line_items, dependent: :destroy

  def total_price
    self.line_items.map do |line_item|
      line_item.product.price*line_item.quantity
    end.sum
  end

  def count_items
    self.line_items.map { |line_item| line_item.quantity }.sum
  end
end
