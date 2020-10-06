class Genre < ApplicationRecord

  validates :name, presence: true
  # validates :is_active, presence: true
  validates :is_active, inclusion: {in: [true, false]}
  has_many :products, dependent: :destroy
end
