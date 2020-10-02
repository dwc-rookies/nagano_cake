class Genre < ApplicationRecord

  validates :name, presence: true
  validates :is_active, presence: true

  has_many :products, dependent: :destroy

end
