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
CategoryValue.find_or_create_by(category_id: 3, name: 'grande')
CategoryValue.find_or_create_by(category_id: 3, name: 'chico')
CategoryValue.find_or_create_by(category_id: 2, name: 'hombre')
CategoryValue.find_or_create_by(category_id: 2, name: 'mujer')
CategoryValue.find_or_create_by(category_id: 1, name: 'cumpleaños')
CategoryValue.find_or_create_by(category_id: 1, name: 'navidad')
Store.create(region_id: 1, name: 'TestStore', email: 'test@gmail.com', password: '12345678', password_confirmation: '12345678')

