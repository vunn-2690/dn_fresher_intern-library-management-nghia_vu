class Book < ApplicationRecord
  belongs_to :shop
  belongs_to :category
  delegate :title, to: :category, prefix: true
  delegate :name, to: :shop, prefix: true
  scope :recent_books, ->{order created_at: :desc}
  scope :seach_by_title, (lambda do |keyword|
    where("title LIKE ?", "%#{keyword}%") if keyword.present?
  end)
  scope :by_book_ids, ->(ids){where id: ids}
end
