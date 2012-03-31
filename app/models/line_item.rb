class LineItem < ActiveRecord::Base
  validates :quantity, format: { with: /^[0-9]+$/ }, allow_blank: true

  belongs_to :product
  belongs_to :cart
  belongs_to :order
end
