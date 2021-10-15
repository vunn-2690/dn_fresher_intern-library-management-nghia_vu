FactoryBot.define do
  factory :shop do
    name {Faker::Company.bs}
    description {"Shop chuyen manga"}
    user_id {create(:user).id}
  end
end
