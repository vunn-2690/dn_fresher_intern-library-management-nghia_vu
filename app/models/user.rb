class User < ApplicationRecord
  before_save :downcase_email
  attr_accessor :remember_token
  enum status: {member: 0, admin: 1}
  has_many :orders, dependent: :destroy
  has_one :shop, dependent: :destroy

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i.freeze

  validates :name, presence: true, length: {minimum: Settings.length.digit_10}
  validates :email, presence: true, uniqueness: true,
    length: {maximum: Settings.length.digit_255},
    format: {with: VALID_EMAIL_REGEX}
  validates :password, length: {minimum: Settings.length.digit_8}
  has_secure_password

  def all_orders
    orders.recent_orders
  end

  def self.digest string
    cost =  if ActiveModel::SecurePassword.min_cost
              BCrypt::Engine::MIN_COST
            else
              BCrypt::Engine.cost
            end
    BCrypt::Password.create string, cost: cost
  end

  def self.new_token
    SecureRandom.urlsafe_base64
  end

  def remember
    self.remember_token = User.new_token
    update_column :remember_digest, User.digest(remember_token)
  end

  def authenticated? attribute, remember_token
    digest = send "#{attribute}_digest"
    return false unless digest

    BCrypt::Password.new(remember_digest).is_password? remember_token
  end

  def forget
    update_column :remember_digest, nil
  end

  def downcase_email
    email.downcase!
  end
end
