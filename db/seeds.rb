# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

City.create(name: "New York")
City.create(name: "San Francisco")
City.create(name: "Chicago")
City.create(name: "New Orleans")
City.create(name: "Washington DC")

Store.create(name: "Flagship New York", city_id: City.find_by(name: "New York").id)
Store.create(name: "Flagship San Francisco", city_id: City.find_by(name: "San Francisco").id)
Store.create(name: "Flagship Chicago", city_id: City.find_by(name: "Chicago").id)
Store.create(name: "Flagship New Orleans", city_id: City.find_by(name: "New Orleans").id)
Store.create(name: "Flagship Washington DC", city_id: City.find_by(name: "Washington DC").id)

Manager.create(name: "Johann", store_id: Store.find_by(name: "Flagship New York").id)
Manager.create(name: "Es", store_id: Store.find_by(name: "Flagship San Francisco").id)
Manager.create(name: "Jeff", store_id: Store.find_by(name: "Flagship Chicago").id)
Manager.create(name: "Paul Blart", store_id: Store.find_by(name: "Flagship Washington DC").id)
Manager.create(name: "Will Smith", store_id: Store.find_by(name: "Flagship New Orleans").id)

Employee.create(name: "Paul", store_id: Store.find_by(name: "Flagship New York").id)
Employee.create(name: "DJ", store_id: Store.find_by(name: "Flagship New York").id)
Employee.create(name: "Will", store_id: Store.find_by(name: "Flagship New York").id)
Employee.create(name: "Alex", store_id: Store.find_by(name: "Flagship New York").id)
