class CartItem < ApplicationRecord

  validates :customer_id, presence: true
  validates :product_id, presence: true
  validates :quantity, presence: true
  validates :quantity, numericality: {only_integer: true}
  validates :quantity, numericality: { greater_than_or_equal_to: 1 } 
  belongs_to :customer
  belongs_to :product

end
