class Order < ApplicationRecord
  enum status: {pending: 0, success: 1, cancel: 2}
  belongs_to :shop
  belongs_to :user
  has_many :order_details, dependent: :destroy
end
