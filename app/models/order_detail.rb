class OrderDetail < ApplicationRecord
  belongs_to :order
  belongs_to :book
  delegate :title, to: :book, prefix: true
end
