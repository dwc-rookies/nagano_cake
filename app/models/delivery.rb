class Delivery < ApplicationRecord

  validates :customer_id, presence: true
  validates :name, presence: true
  validates :postcode, presence: true
  validates :postcode, numericality: {only_integer: true}, length: { minimum: 7 }
  validates :address, presence: true

  belongs_to :customer

end
