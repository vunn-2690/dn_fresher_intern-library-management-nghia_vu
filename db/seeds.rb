Category.create!(
  title: "Manga",
  description: "Truyện tranh xuất phát từ Nhật Bản.")
Category.create!(
  title: "Học tập",
  description: "Tất cả các loại sách về học tập")
User.create!(
  name: " Admin Admin ",
  email: "admin@gmail.com",
  password: "123123123",
  password_confirmation: "123123123",
  status: 1)
User.create!(
  name: "Example User1",
  email: "a@gmail.com",
  password: "123123123",
  password_confirmation: "123123123")
User.create!(
  name: "Example User2",
  email: "v@gmail.com",
  password: "123123123",
  password_confirmation: "123123123")
Shop.create!(
  name: "Manga Shop",
  description: "Shop chuyên manga",
  user_id: 2)
Shop.create!(
  name: "SGK Shop",
  description: "Shop chuyên sách về học tập",
  user_id: 3)
15.times do |n|
  title = "Manga-#{n+1}"
  price = n*10000
  description = "Hay lam hihi"
  quantity = 20
  shop_id = 1
  category_id = 1
  Book.create!(
  title: title,
  price: price,
  description: description,
  quantity: quantity,
  shop_id: shop_id,
  category_id: category_id)
end

15.times do |n|
  title = "SGK-#{n+1}"
  price = n*10000
  description = "Hay lam hihi"
  quantity = 20
  shop_id = 2
  category_id = 2
  Book.create!(
  title: title,
  price: price,
  description: description,
  quantity: quantity,
  shop_id: shop_id,
  category_id: category_id)
end
