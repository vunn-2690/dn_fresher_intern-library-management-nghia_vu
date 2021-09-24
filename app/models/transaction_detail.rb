class TransactionDetail < ApplicationRecord
  belongs_to :transaction
  belongs_to :book
end
