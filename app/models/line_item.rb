class LineItem < ActiveRecord::Base

def total_price
	product.price * quantity
end
  attr_accessible :cart_id, :product_id, :quantity

  belongs_to :product
  belongs_to :cart
end

	