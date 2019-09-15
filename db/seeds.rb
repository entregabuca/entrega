# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
def col_address
  if Random.rand(0..1).even?
    col_address = "Bucaramanga, Colombia, Calle #{Random.rand(1..100)} No #{Random.rand(1..50)} - #{Random.rand(1..80)}"
  else
    col_address = "Bucaramanga, Colombia, Carrera #{Random.rand(1..50)} No #{Random.rand(1..100)} - #{Random.rand(1..80)}"
  end
end


N=10

OrderStatus.delete_all
Order.delete_all
Sender.delete_all
Transporter.delete_all
Company.delete_all


### Senders
sender = Array.new(N)

N.times do |i|
  sender[i] = Sender.create(
    name: Faker::Name.unique.name,
    telephone: (Faker::PhoneNumber.cell_phone).to_s,
    email: "s#{i}@s.com",#Faker::Internet.email,    
    status: Random.rand(2),
    password: "123456",
    password_confirmation: "123456" 
  )
  sender[i].locations.create(address: col_address,
    latitude: Random.rand*(0.04)+7.1,
    longitude: Random.rand*(0.03)-73.13
  )
  puts "Sender #{i}: #{sender[i].name} created!"
end

### Companies
company = Array.new(N)

N.times do |i|
  company[i] = Company.create(
    name: Faker::Company.unique.name,
    telephone: (Faker::PhoneNumber.phone_number).to_s,
    email: "c#{i}@c.com",#Faker::Internet.email,    
    radius: 10000,
    status: Random.rand(2),
    password: "123456",
    password_confirmation: "123456"
  )
  company[i].locations.create(address: col_address,
    latitude: Random.rand*(0.04)+7.1,
    longitude: Random.rand*(0.03)-73.13
  )
  puts "Company #{i}: #{company[i].name} created!"
end

### Transporters
transporter = Array.new(4*N)

(4*N).times do |i|
  transporter[i] = Transporter.create(
    name: Faker::Name.unique.name,
    telephone: (Faker::PhoneNumber.cell_phone).to_s,
    email: "t#{i}@t.com",#Faker::Internet.email,
    company: company[Random.rand(N)],
    status: Random.rand(2),
    password: "123456",
    password_confirmation: "123456"
  )
  puts "Transporter #{i}: #{transporter[i].name} created!"
end

### Orders
order = Array.new(7*N)

(10*N).times do |i|
  st = Random.rand(6)
  st > 1 ? tr = transporter[Random.rand(4*N)] : tr = nil
  order[i] = Order.create(
    description: Faker::Food.ingredient,
    weight: Faker::Number.decimal(l_digits: 2),
    length: Faker::Number.decimal(l_digits: 2),
    width: Faker::Number.decimal(l_digits: 2),
    heigth: Faker::Number.decimal(l_digits: 2),
    pickup_time: Faker::Time.between(from: DateTime.now, to: DateTime.now + 3),
    delivery_time: Faker::Time.between(from: DateTime.now + 4, to: DateTime.now + 5),
    cost: Faker::Number.between(from: 10000, to: 90000),
    status: st,
    sender: sender[Random.rand(N)],
    transporter: tr,
    radius: 500*(Random.rand(4)+1)
  )
  order[i].locations.create(address: col_address,
    latitude: Random.rand*(0.04)+7.1,
    longitude: Random.rand*(0.03)-73.13
  )
  order[i].locations.create(address: col_address,
    latitude: Random.rand*(0.04)+7.1,
    longitude: Random.rand*(0.03)-73.13
  )
  OrderStatus.create(
    status: st,
    status_time: Time.now(),
    status_details: Faker::GreekPhilosophers.quote,
    order: order[i]
  )
  puts "Order for #{i}: #{order[i].sender.name} Staus: #{order[i].order_statuses.first.status} created!"
end
