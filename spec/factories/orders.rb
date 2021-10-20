FactoryBot.define do
  factory :order do
    total_price{Faker::Number.between(from: 50000, to: 125000)}
    name{Faker::Name.name}
    address{"123 DN"}
    phone{"0123123123"}
    shop_id{create(:shop).id}
    user_id{create(:user).id}
  end
end
