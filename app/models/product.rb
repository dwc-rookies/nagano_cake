class Product < ApplicationRecord

  validates :name, presence: true
  validates :description, presence: true
  validates :genre_id, presence: true
  validates :tax_excluded_price, presence: true
  validates :is_active, inclusion: {in: [true, false]}

  belongs_to :genre, optional: true
  has_many :cart_items, dependent: :destroy
  has_many :ordered_products, dependent: :destroy

  attachment :image

end
