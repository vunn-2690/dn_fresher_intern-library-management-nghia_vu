class Book < ApplicationRecord
  belongs_to :shop
  belongs_to :category
  scope :recent_books, ->{order created_at: :desc}
  scope :seach_by_title, (lambda do |keyword|
    where("title LIKE ?", "%#{keyword}%") if keyword.present?
  end)
end
