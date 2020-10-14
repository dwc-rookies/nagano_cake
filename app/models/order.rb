class Order < ApplicationRecord

  validates :customer_id, presence: true
  validates :postage, presence: true
  validates :postage, numericality: {only_integer: true}
  validates :charge, presence: true
  validates :charge, numericality: {only_integer: true}
  validates :pay, presence: true
  validates :status, presence: true
  validates :postcode, presence: true
  validates :postcode, numericality: {only_integer: true}
  validates :postcode, length: { minimum: 7 }
  validates :address, presence: true
  validates :name, presence: true

  enum pay: {credit_card: 0, bank_transfer: 1}


  belongs_to :customer
  has_many :orderd_products, dependent: :destroy


end
