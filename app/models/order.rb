class Order < ApplicationRecord

  validates :customer_id, presence: true
  validates :postage, presence: true
  validates :charge, presence: true
  validates :pay, presence: true
  validates :status, presence: true
  validates :postcode, presence: true
  validates :address, presence: true
  validates :name, presence: true

  enum pay: {credit_card: 1, bank_transfer: 2}


  belongs_to :customer
  has_many :orderd_products, dependent: :destroy


end
