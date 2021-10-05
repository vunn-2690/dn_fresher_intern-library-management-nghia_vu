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
  name: "Example User",
  email: "a@gmail.com",
  password: "123123123",
  password_confirmation: "123123123")
User.create!(
  name: "Dinh Nguyen Phu Nghia",
  email: "b@gmail.com",
  password: "123123123",
  password_confirmation: "123123123")
User.create!(
  name: "Nguyen Nam Vu",
  email: "c@gmail.com",
  password: "123123123",
  password_confirmation: "123123123")
User.create!(
  name: "Example User2",
  email: "d@gmail.com",
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
Order.create!(
  status: 1,
  name: "Example Customer",
  address: "123 Example",
  phone: "0905666666",
  total_price: 175000,
  shop_id: 1,
  user_id: 2)
Order.create!(
  status: 2,
  name: "Example Customer 2",
  address: "12345 Example",
  phone: "0905666666",
  total_price: 125000,
  shop_id: 1,
  user_id: 2)
Order.create!(
  name: "Nguyen Nam Vu",
  address: "12345 Example",
  phone: "0905666666",
  total_price: 75000,
  shop_id: 1,
  user_id: 3)
5.times do |n|
  quantily = 1
  price = 75000
  order_id = 1
  book_id = n+1
  OrderDetail.create!(
  quantily: quantily,
  price: price,
  order_id: order_id,
  book_id: book_id
  )
end
5.times do |n|
  quantily = 1
  price = 125000
  order_id = 2
  book_id = n+2
  OrderDetail.create!(
  quantily: quantily,
  price: price,
  order_id: order_id,
  book_id: book_id
  )
end
