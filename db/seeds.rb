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
Relation.find_or_create_by(name: 'Jefe')
Relation.find_or_create_by(name: 'Jefe')
Relation.find_or_create_by(name: 'Mamá')
Relation.find_or_create_by(name: 'Hermano')
Relation.find_or_create_by(name: 'Novia')
Region.find_or_create_by(name: 'Chile')
Region.find_or_create_by(name: 'Brasil')
Region.find_or_create_by(name: 'Argentina')
Category.find_or_create_by(name: 'Ocasion')
Category.find_or_create_by(name: 'Género')
Category.find_or_create_by(name: 'Tamaño')
Store.create(region_id: 1, name: 'TestStore', email: 'test@gmail.com', password: '12345678', password_confirmation: '12345678')
Product.find_or_create_by(name: 'cafetera',store_id: 1, price: 4990, link:'https://www.facebook.com/', clicks_cost: 20)
coffee = Product.find_or_create_by(name: 'cafetera')
coffee.image.attach(io: File.open('app/assets/products/cafetera.jpg'), filename: "cafetera.jpg")
Product.find_or_create_by(name: 'Chocolates',store_id: 1, price: 8990, link:'https://www.facebook.com/', clicks_cost: 20)
chocolate = Product.find_or_create_by(name: 'Chocolates')
chocolate.image.attach(io: File.open('app/assets/products/chocolates.jpg'), filename: "chocolates.jpg")
Product.find_or_create_by(name: 'Juguete',store_id: 1, price: 3000, link:'https://www.facebook.com/', clicks_cost: 15)
toy = Product.find_or_create_by(name: 'Juguete')
toy.image.attach(io: File.open('app/assets/products/toy.jpg'), filename: "toy.jpg")
Product.find_or_create_by(name: 'Peluche', store_id: 1, price: 15000, link:'https://www.facebook.com/', clicks_cost: 35)
teddy = Product.find_or_create_by(name: 'Peluche')
teddy.image.attach(io: File.open('app/assets/products/teddy.jpg'), filename: "teddy.jpg")
Product.find_or_create_by(name: 'Crocs', store_id: 1, price: 32000, link:'https://www.facebook.com/', clicks_cost: 35)
crocs = Product.find_or_create_by(name: 'Crocs')
crocs.image.attach(io: File.open('app/assets/products/crocs.jpeg'), filename: "crocs.jpeg")
Product.find_or_create_by(name: 'Camisa', store_id: 1, price: 45000, link:'https://www.facebook.com/', clicks_cost: 315)
shirt = Product.find_or_create_by(name: 'Camisa')
shirt.image.attach(io: File.open('app/assets/products/shirt.jpg'), filename: "shirt.jpg")
Product.find_or_create_by(name: 'Peluche', store_id: 1, price: 15000, link:'https://www.facebook.com/', clicks_cost: 35)
dress = Product.find_or_create_by(name: 'Vestido')
dress.image.attach(io: File.open('app/assets/products/dress.jpg'), filename: "dress.jpg")
Product.find_or_create_by(name: 'Jeans', store_id: 1, price: 26990, link:'https://www.facebook.com/', clicks_cost: 112)
jeans = Product.find_or_create_by(name: 'Jeans')
jeans.image.attach(io: File.open('app/assets/products/jeans.jpg'), filename: "jeans.jpg")
Product.find_or_create_by(name: 'Zapatos', store_id: 1, price: 33500, link:'https://www.facebook.com/', clicks_cost: 84)
shoes = Product.find_or_create_by(name: 'Zapatos')
shoes.image.attach(io: File.open('app/assets/products/shoes.jpg'), filename: "shoes.jpg")
Product.find_or_create_by(name: 'Collar de oro', store_id: 1, price: 120000, link:'https://www.facebook.com/', clicks_cost: 98)
necklace = Product.find_or_create_by(name: 'Collar de oro')
necklace.image.attach(io: File.open('app/assets/products/necklace.png'), filename: "necklace.png")
