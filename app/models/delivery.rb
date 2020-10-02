class Delivery < ApplicationRecord

  validates :customer_id, presence: true
  validates :name, presence: true
  validates :postcode, presence: true
  validates :address, presence: true

  belongs_to :customer

end
