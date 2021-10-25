class User < ApplicationRecord
  devise :database_authenticatable, :rememberable, :validatable
  before_save :downcase_email
  enum status: {member: 0, admin: 1}
  has_many :orders, dependent: :destroy
  has_one :shop, dependent: :destroy

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i.freeze

  validates :name, presence: true, length: {minimum: Settings.length.digit_10}
  validates :email, presence: true, uniqueness: true,
    length: {maximum: Settings.length.digit_255},
    format: {with: VALID_EMAIL_REGEX}
  validates :password, length: {minimum: Settings.length.digit_8}

  def all_orders
    orders.recent_orders
  end

  def downcase_email
    email.downcase!
  end
end
