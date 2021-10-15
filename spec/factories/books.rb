FactoryBot.define do
  factory :book do
    title {Faker::Book.title}
    price {Faker::Number.between(from: 50000, to: 125000)}
    description {Faker::Book.publisher}
    quantity {Faker::Number.between(from: 1, to: 50)}
    shop_id {create(:shop).id}
    category_id{create(:category).id}
  end
end
