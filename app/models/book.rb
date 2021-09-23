class Book < ApplicationRecord
  belongs_to :shop
  belongs_to :category
end
