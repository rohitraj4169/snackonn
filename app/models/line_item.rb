class LineItem < ActiveRecord::Base
  belongs_to :product
  belongs_to :cart
  has_many :order

  # LOGIC
  def total_price
    self.quantity * self.product.price
  end
end