class Product < ApplicationRecord

  validates :genre_id, presence: true
  validates :name, presence: true
  validates :tax_excluded_price, presence: true
  validates :description, presence: true
  validates :image_id, presence: true
  validates :is_active, presence: true

  belongs_to :genre
  has_many :cart_items, dependent: :destroy
  has_many :ordered_products, dependent: :destroy

end
