FactoryBot.define do
  factory :shop do
    name {Faker::Book.title}
    description {"Shop chuyen manga"}
    user_id {create(:user).id}
  end
end
