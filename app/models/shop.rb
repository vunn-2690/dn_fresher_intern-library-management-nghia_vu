class Shop < ApplicationRecord
  belongs_to :user
  has_many :books, dependent: :destroy
  scope :search_by_name, (lambda do |keyword|
    where("name LIKE ?", "%#{keyword}%") if keyword.present?
  end)

  def all_books
    self.books.recent_books
  end
end
