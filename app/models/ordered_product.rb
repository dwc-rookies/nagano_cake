class OrderedProduct < ApplicationRecord

  validates :order_id, presence: true
  validates :product_id, presence: true
  validates :quantity, presence: true
  validates :quantity, numericality: {only_integer: true}
  validates :quantity, numericality: { greater_than_or_equal_to: 1 } 
  validates :purchase_money, presence: true
  validates :purchase_money, numericality: {only_integer: true}
  validates :production_status, presence: true

  belongs_to :order
  belongs_to :product

end
