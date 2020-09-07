# This file should contain all the record creation needed to seed the database
# with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
# Write the code in a way that can be executed multiple times without duplicating the information.
#
# For example:
#
# Country.create(name: "Chile") # BAD
# Country.find_or_create_by(name: "Chile") # GOOD
#
Region.find_or_create_by(name: 'Chile')
Region.find_or_create_by(name: 'Brasil')
Region.find_or_create_by(name: 'Argentina')

Store.create(region_id: 1, name: 'TestStore', email: 'test@gmail.com', password: '12345678', password_confirmation: '12345678')

coffee_makers = Category.find_or_create_by(name: 'cafeteras', description: 'máquinas para hacer café')
coffee = Product.find_or_create_by(name: 'Cafetera Francesa', store_id: 1, price: 4990, link:'https://www.facebook.com/', clicks_cost: 20, category: coffee_makers, email: 'dummy@example.com')
coffee.image.attach(io: File.open('app/assets/products/cafetera.jpg'), filename: "cafetera.jpg")
coffee = Product.find_or_create_by(name: 'Cafetera Eléctrica', store_id: 1, price: 9990, link:'https://www.facebook.com/', clicks_cost: 20, category: coffee_makers, email: 'dummy@example.com')
coffee.image.attach(io: File.open('app/assets/products/cafetera2.jpg'), filename: "cafetera2.jpg")
coffee = Product.find_or_create_by(name: 'Cafetera Espresso', store_id: 1, price: 15990, link:'https://www.facebook.com/', clicks_cost: 20, category: coffee_makers, email: 'dummy@example.com')
coffee.image.attach(io: File.open('app/assets/products/cafetera3.jpg'), filename: "cafetera3.jpg")

chocolates = Category.find_or_create_by(name: 'chocolates', description: 'chocolates')
chocolate = Product.find_or_create_by(name: 'Chocolates', store_id: 1, price: 4990, link:'https://www.facebook.com/', clicks_cost: 20, category: chocolates, email: 'dummy@example.com')
chocolate.image.attach(io: File.open('app/assets/products/chocolate.jpg'), filename: "chocolate.jpg")
chocolate = Product.find_or_create_by(name: 'Chocolate 2', store_id: 1, price: 9990, link:'https://www.facebook.com/', clicks_cost: 20, category: chocolates, email: 'dummy@example.com')
chocolate.image.attach(io: File.open('app/assets/products/chocolate2.jpg'), filename: "chocolate2.jpg")
chocolate = Product.find_or_create_by(name: 'Chocolate 3', store_id: 1, price: 15990, link:'https://www.facebook.com/', clicks_cost: 20, category: chocolates, email: 'dummy@example.com')
chocolate.image.attach(io: File.open('app/assets/products/chocolate3.jpg'), filename: "chocolate3.jpg")

beers = Category.find_or_create_by(name: 'cervezas', description: 'cervezas')
beer = Product.find_or_create_by(name: 'Cerveza simple', store_id: 1, price: 499, link:'https://www.facebook.com/', clicks_cost: 20, category: beers, email: 'dummy@example.com')
beer.image.attach(io: File.open('app/assets/products/cerveza1.jpg'), filename: "cerveza1.jpg")
beer = Product.find_or_create_by(name: 'Pack de cervezas (opción 1)', store_id: 1, price: 4990, link:'https://www.facebook.com/', clicks_cost: 20, category: beers, email: 'dummy@example.com')
beer.image.attach(io: File.open('app/assets/products/cerveza2.jpg'), filename: "cerveza2.jpg")
beer = Product.find_or_create_by(name: 'Pack de cervezas (opción 2)', store_id: 1, price: 19990, link:'https://www.facebook.com/', clicks_cost: 20, category: beers, email: 'dummy@example.com')
beer.image.attach(io: File.open('app/assets/products/cerveza3.jpg'), filename: "cerveza3.jpg")
