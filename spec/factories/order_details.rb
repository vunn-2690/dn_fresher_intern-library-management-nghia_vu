FactoryBot.define do
  factory :order_detail do
    quantily{Faker::Number.between(from: 1, to: 10)}
    price{Faker::Number.between(from: 50000, to: 125000)}
    order_id{create(:order).id}
    book_id{create(:book).id}
  end
end
