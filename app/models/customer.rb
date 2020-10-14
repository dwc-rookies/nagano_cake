class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  validates :last_name, presence: true
  validates :first_name, presence: true
  validates :last_name_kana, presence: true
  validates :first_name_kana, presence: true
  validates :postcode, presence: true
  validates :postcode, numericality: {only_integer: true}
  validates :postcode, length: { minimum: 7 }
  validates :address, presence: true
  validates :phone_number, presence: true
  validates :phone_number, numericality: {only_integer: true}
  validates :phone_number, length: { minimum: 9 }
  validates :is_deleated, inclusion: {in: [true, false]}

  has_many :deliveries, dependent: :destroy
  has_many :orders, dependent: :destroy
  has_many :cart_items, dependent: :destroy
  def active_for_authentication?
    super && (self.is_deleated == false)
  end

  def self.search(search)
    if search
      Customer.where(['last_name LIKE ? OR first_name LIKE ?', "%#{search}%", "%#{search}%"])
    else
      Customer.all
    end
  end

end
