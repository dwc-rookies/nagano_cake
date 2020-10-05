class Genre < ApplicationRecord

  validates :name, presence: true
  validates :is_active, presence: true

  has_many :products, dependent: :destroy
  boolean is_active:{有効：false,無効:true}
end
