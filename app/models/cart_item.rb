class CartItem < ApplicationRecord

  validates :customer_id, presence: true
  validates :product_id, presence: true
  validates :quantity, presence: true

  belongs_to :customer
  belongs_to :product

end
