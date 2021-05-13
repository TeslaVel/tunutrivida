# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)



male =Gender.create(name: "Male", description: "Male")
female =Gender.create(name: "Female", description: "Female")
other =Gender.create(name: "Ohter", description: "Ohter")

role_dietitian = Role.create(name: 'dietitian', description: "Dietitian")
role_amin = Role.create(name: 'super_admin', description: "Super Admin")

user = User.create(
	email: 'admin@example.com',
	first_name: 'Admin 1',
	last_name: 'Admin 1',
	password: '2351310',
	password_confirmation: '2351310'
)
UserRole.create(user:user ,role: role_dietitian)
UserRole.create(user:user ,role: role_amin)


dietitian = User.create(
	email: 'dietitian1@example.com',
	first_name: "Mary",
	last_name: "Watson",
	password: '2351310',
	password_confirmation: '2351310'
)
UserRole.create(user:dietitian ,role: role_dietitian)



y1=15
y2=70
gender = rand(1..2)

weight = rand(50.20...88.90).round(2)
height = rand(1.50...1.90).round(2)
waist = rand(60.3...75.90).round(2)
hip = rand(70.3...99.90).round(2)
dob =Time.now - rand(y1...y2).years
created = Time.now - rand(1..7).days
imc = (weight / (height*height)).round(2)
patient1 = Patient.create(first_name: "Lucia", last_name: "Mora", dietitian_id: dietitian.id, gender: female , date_of_bird: dob)
Session.create(
	weight: weight,height: height,
	waist: waist,hip: hip,
	imc: imc,desired_imc: imc,
	date: created,
	dietitian_id: dietitian.id,
	patient_id: patient1.id
)
weight = weight+rand(1..4)
imc = (weight / (height*height)).round(2)
Session.create(
	weight: weight,height: height,
	waist: waist+rand(1..4),hip: hip+rand(1..2),
	imc: imc,desired_imc: imc,
	date: created + 7.day,
	dietitian_id: dietitian.id,
	patient_id: patient1.id
)

weight = rand(50.20...88.90).round(2)
height = rand(1.50...1.90).round(2)
waist = rand(60.3...75.90).round(2)
hip = rand(70.3...99.90).round(2)
dob =Time.now - rand(y1...y2).years
created = Time.now - rand(1..7).days
patient2 = Patient.create(first_name: "Marina", last_name: "Perdomo", dietitian_id: dietitian.id, gender: female , date_of_bird: dob)
Session.create(
weight: weight,height: height,
waist: waist,hip: hip,
imc: imc,desired_imc: imc,
date: created,
dietitian_id: dietitian.id,
patient_id: patient2.id
)
weight = weight+rand(1..4)
imc = (weight / (height*height)).round(2)
Session.create(
	weight: weight,height: height,
	waist: waist+rand(1..4),hip: hip+rand(1..2),
	imc: imc,desired_imc: imc,
	date: created + 7.day,
	dietitian_id: dietitian.id,
	patient_id: patient2.id
)

weight = rand(50.20...88.90).round(2)
height = rand(1.50...1.90).round(2)
waist = rand(60.3...75.90).round(2)
hip = rand(70.3...99.90).round(2)
dob =Time.now - rand(y1...y2).years
created = Time.now - rand(1..7).days
patient3 = Patient.create(first_name: Faker::Name.name, last_name: Faker::Name.last_name, dietitian_id: dietitian.id, gender: female , date_of_bird: dob)
Session.create(
	weight: weight,height: height,
	waist: waist,hip: hip,
	imc: imc,desired_imc: imc,
	date: created,
	dietitian_id: dietitian.id,
	patient_id: patient3.id
)

weight = weight+rand(1..4)
imc = (weight / (height*height)).round(2)
Session.create(
	weight: weight,height: height,
	waist: waist+rand(1..4),hip: hip+rand(1..2),
	imc: imc,desired_imc: imc,
	date: created + 7.day,
	dietitian_id: dietitian.id,
	patient_id: patient3.id
)
