class OrderedProduct < ApplicationRecord

  validates :order_id, presence: true
  validates :product_id, presence: true
  validates :quantity, presence: true
  validates :purchase_money, presence: true
  validates :production_status, presence: true

  belongs_to :order
  belongs_to :product

end
