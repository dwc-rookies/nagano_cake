class Product < ApplicationRecord

  validates :name, presence: true
  validates :description, presence: true
  validates :genre_id, presence: true
  validates :tax_excluded_price, presence: true
  validates :tax_excluded_price, numericality: {only_integer: true}
  validates :is_active, inclusion: {in: [true, false]}

  belongs_to :genre, optional: true
  has_many :cart_items, dependent: :destroy
  has_many :ordered_products, dependent: :destroy

  attachment :image

  def self.search(search)
    if search
      Product.where(['name LIKE ?', "%#{search}%"])
    else
      Product.all
    end
  end

end
