class Order < ApplicationRecord
  enum status: {pending: 0, success: 1, cancel: 2, disclaim: 3}
  belongs_to :shop
  belongs_to :user
  has_many :order_details, dependent: :destroy
  delegate :name, to: :user, prefix: true
  scope :recent_orders, ->{order created_at: :desc}
  validates :name, :address, :phone, presence: true
end
