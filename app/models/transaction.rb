class Transaction < ApplicationRecord
  enum status: {pending: 0, success: 1, cancel: 2}
  belongs_to :shop
  belongs_to :user
end
