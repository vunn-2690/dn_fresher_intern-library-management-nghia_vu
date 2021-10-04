class Shop < ApplicationRecord
  belongs_to :user
  has_many :books, dependent: :destroy
  has_many :orders, dependent: :destroy

  scope :search_by_name, (lambda do |keyword|
    where("name LIKE ?", "%#{keyword}%") if keyword.present?
  end)

  def all_books
    books.recent_books
  end

  def all_orders
    orders.recent_orders
  end
end
