Category.create!(
  title: "Manga",
  description: "Truyện tranh xuất phát từ Nhật Bản.")
Category.create!(
  title: "Học tập",
  description: "Tất cả các loại sách về học tập")
User.create!(
  name: "Example User",
  email: "a@gmail.com",
  password: "123123123",
  password_confirmation: "123123123")
Shop.create!(
  name: "Manga Shop",
  description: "Shop chuyên manga",
  user_id: 1)
30.times do |n|
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
