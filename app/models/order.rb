class Order < ActiveRecord::Base
  attr_protected :all

  attr_accessor :credit_card

  has_many :line_items
  belongs_to :user

  scope :unpaid, where(pay_status: 'unpaid')
  scope :paid, where(pay_status: 'paid')

  def build_line_items(cart)
    cart.line_items.each  do |item|
      item.cart_id = nil
      line_items << item
    end
  end

  def purchase(credit_card, ip)
    gateway = ActiveMerchant::Billing::PaypalGateway.new(
      login:     "griglm_1332980966_biz_api1.gmail.com",
      password:  "1332981003",
      signature: "AiPC9BjkCyDFQXbSkoZcgqH3hpacAck9J23Cb7A7mLznM5pd7-wR3HkY"
    )
    price_in_cents = self.total_price*100
    gateway.purchase(price_in_cents, credit_card, ip: ip)
  end

  def calculate_total_price
    self.total_price = self.line_items.map do |line_item|
      line_item.product.price*line_item.quantity
    end.sum
  end
end
