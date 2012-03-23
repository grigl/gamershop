class Order < ActiveRecord::Base
  has_many :line_items
  belongs_to :user

  scope :unpaid, where(pay_status: 'unpaid')
  scope :paid, where(pay_status: 'paid')


  def self.payment_types
    ['paypal','robokassa','courier']
  end

  def build_line_items(cart)
    cart.line_items.each  do |item|
      item.cart_id = nil
      line_items << item
    end
  end
end
