# Here is created
# Organization
# Genders
# Admin Users
# Roles
# OrganizationMemberships
# Some Availabilities
# AppointmentSetting
# GlobalConfiguration
# Algunos typs de indicadores e indicadores
# BmrFactor
# Prducts
# Discount
# Package
# Activity Factos

org = Organization.create(
	name: 'Tunutrivida',
	description: 'Dieititan and patients web'
)

puts "Created Organization: #{org.name}"


puts 'Creating Genders'
male = Gender.create(name: 'Male', description: 'Male')
female = Gender.create(name: 'Female', description: 'Female')
other = Gender.create(name: 'Ohter', description: 'Ohter')
both = Gender.create(name: 'Both', description: 'Both')

user = User.create!(
	email: 'm3taljose@gmail.com',
	username: 'm3taljose',
	first_name: 'Admin 1',
	last_name: 'Admin 1',
	password: '2351310',
	password_confirmation: '2351310',
	organization_id: org.id,
	status: :active,
	gender: male
)

puts "Created admin: #{user.email}"


dietitian = User.create!(
	email: 'tunutrividalb@gmail.com',
	username: 'tunutrividalb',
	first_name: 'Lic Laura',
	last_name: 'Berrios',
	password: '2351310',
	password_confirmation: '2351310',
	organization_id: org.id,
	status: :active,
	gender: female
)
puts "Created dietitian: #{dietitian.email}"

role_dietitian = Role.create(name: 'dietitian', description: 'Dietitian', created_by_id: user.id)
role_amin = Role.create(name: 'super_admin', description: 'Super Admin', created_by_id: user.id)
role_patient = Role.create(name: 'patient', description: 'Patient', created_by_id: user.id)
puts "Created roles: #{role_dietitian.name}, #{role_amin.name}, #{role_patient.name}"

dietitian.add_role :dietitian
user.add_role :dietitian
user.add_role :super_admin

OrganizationMemberships.create(
	is_admin: 1,
	organization_id: org.id,
	user_id: user.id
)

OrganizationMemberships.create(
	is_admin: 0,
	organization_id: org.id,
	user_id: dietitian.id
)

puts "Creating Availability for #{dietitian.first_name}"
available1 = Availability.create(
	time_start: '09:30'.to_time,
	time_end: '23:00'.to_time,
	dietitian_id: dietitian.id
)

puts "Creating AppointmentSetting for #{dietitian.first_name}"
AppointmentSetting.create(
	time_step: 5,
	dietitian_id: dietitian.id
)

puts 'Creating GlobalConfiguration'
glb = GlobalConfiguration.create(
	currency: 'USD',
	currency_code: '$',
	target_currency: 'VES',
	target_currency_code: 'Bs',
	target_conversion: '24.45',
	created_by_id: 1
)

puts "Creating IndicatorTypes"
type_imc = IndicatorType.create(name: "IMC", description: "IMC", created_by_id: user.id)
type_pdc = IndicatorType.create(name: "PDC", description: "Perimetro de cintura", created_by_id: user.id)
type_icc = IndicatorType.create(name: "ICC", description: "Indice cintura cadera ", created_by_id: user.id)

puts "Creating Indicators"
Indicator.create(value_min: 0.0, value_max: 18.4 , name: 'Bajo peso', gender: both, position: 1, indicator_type: type_imc, created_by_id: user.id)
Indicator.create(value_min: 18.41, value_max: 24.9 , name: 'Normo peso', gender: both, position: 2, indicator_type: type_imc, created_by_id: user.id)
Indicator.create(value_min: 25.0, value_max: 29.9 , name: 'Sobre Peso', gender: both, position: 3, indicator_type: type_imc, created_by_id: user.id)
Indicator.create(value_min: 30.0, value_max: 34.9 , name: 'Obesidad I', gender: both, position: 4, indicator_type: type_imc, created_by_id: user.id)
Indicator.create(value_min: 35.0, value_max: 39.9 , name: 'Obesidad II', gender: both, position: 5, indicator_type: type_imc, created_by_id: user.id)
Indicator.create(value_min: 40, value_max: 999 , name: 'Obesidad morbida', gender: both, position: 6, indicator_type: type_imc, created_by_id: user.id)

Indicator.create(value_min: 0.0, value_max: 80 , name: 'Bajo', gender: female, position: 1, indicator_type: type_pdc, created_by_id: user.id)
Indicator.create(value_min: 80, value_max: 88.1 , name: 'Aumentado', gender: female, position: 2, indicator_type: type_pdc, created_by_id: user.id)
Indicator.create(value_min: 88.0, value_max: 999 , name: 'Aumentado', gender: female, position: 2, indicator_type: type_pdc, created_by_id: user.id)

#compara cintura
Indicator.create(value_min: 0.0, value_max: 94 , name: 'Bajo', gender: male, position: 1, indicator_type: type_pdc, created_by_id: user.id)
Indicator.create(value_min: 94.0, value_max: 102.1 , name: 'Aumentado', gender: male, position: 2, indicator_type: type_pdc, created_by_id: user.id)
Indicator.create(value_min: 102.0, value_max: 999 , name: 'Aumentado', gender: male, position: 3, indicator_type: type_pdc, created_by_id: user.id)

#icc cintura / cadera
Indicator.create(value_min: 0.0, value_max: 0.80 , name: 'Sin riesgo', gender: female, position: 1, indicator_type: type_icc, created_by_id: user.id)
Indicator.create(value_min: 0.80, value_max: 999 , name: 'Con Riesgo', gender: female, position: 2, indicator_type: type_icc, created_by_id: user.id)

Indicator.create(value_min: 0.0, value_max: 0.9 , name: 'Sin riesgo', gender: male, position: 1, indicator_type: type_icc, created_by_id: user.id)
Indicator.create(value_min: 0.9, value_max: 999 , name: 'Con Riesgo', gender: male, position: 2, indicator_type: type_icc, created_by_id: user.id)


# CONST BMR
puts "Creating BMR FACTORS"
sleep(2)
BmrFactor.create!(
	base_value: 66.473,
	base_weight: 13.751,
	base_height: 5.0033,
	base_age: 6.55,
	position: 1,
	gender: male,
	created_by_id: user.id,
	name: 'Benedict',
	source: 1
)

BmrFactor.create!(
	base_value: 665.51,
	base_weight: 9.463,
	base_height: 1.8496,
	base_age: 4.6756,
	position: 1,
	gender: female,
	created_by_id: user.id,
	name: 'Benedict',
	source: 1
)

BmrFactor.create!(
	base_value: 5,
	base_weight: 10,
	base_height: 6.25,
	base_age: 5,
	position: 1,
	gender: male,
	created_by_id: user.id,
	name: 'Mifflin	',
	source: 2
)

BmrFactor.create!(
	base_value: 161,
	base_weight: 10,
	base_height: 6.25,
	base_age: 5,
	position: 1,
	gender: female,
	created_by_id: user.id,
	name: 'Mifflin',
	source: 2
)

puts "Creating Products"
Product.create(
	name: "Balines x4",
	description: 'Balines Magneticos',
	price: '12.5',
	status: 1,
	created_by_id: dietitian.id
)

Product.create(
	name: "Pastilla Nutt",
	description: 'Pastillas supresora de alimento',
	price: '5.2',
	status: 1,
	created_by_id: dietitian.id
)

puts "Creating Discounts"
Discount.create(
	name: "2.5 | Bienvenida",
	description: '-2.5 de descuento',
	amount: '2.5',
	status: 1,
	created_by_id: dietitian.id
)

Discount.create(
	name: "%5 | gift",
	description: "-5% de descuento",
	amount: '5',
	status: 1,
	created_by_id: dietitian.id
)

puts "Creating Packages"
Package.create!(name: "Empty Package", description: "Paquete Vacio", price: 0, weeks: 0, created_by_id: user.id)
Package.create!(name: "Paquete 1 semanas", description: "Paquete que incluye tal y tal", price: 25.00, weeks: 1, session_quantity: 1, created_by_id: user.id)
Package.create!(name: "Paquete 2 semanas", description: "Paquete que incluye tal y tal", price: 36.80, weeks: 2, session_quantity: 1,created_by_id: user.id)
Package.create!(name: "Paquete 3 semanas", description: "Paquete que incluye tal y tal", price: 60, weeks: 3, session_quantity: 1, created_by_id: user.id)
Package.create!(name: "Paquete 4 semanas", description: "Paquete que incluye tal y tal", price: 81.50, weeks: 4, session_quantity: 1, created_by_id: user.id)
Package.create!(name: "Paquete 5 semanas", description: "Paquete que incluye tal y tal", price: 126.00, weeks: 5, session_quantity: 1, created_by_id: user.id)

puts "Creating ActivityFactor"
ActivityFactor.create!(name: "Sedentario", description: "(poco o ningun ejercicio)", value: 1.2, created_by_id: user.id)
ActivityFactor.create!(name: "Ligeramente activo", description: "(ejercicio ligero / deportes 1-3 dias / semana)", value: 1.375, created_by_id: user.id)
ActivityFactor.create!(name: "Moderadamente activo", description: "(ejercicio moderado / deportes 3-5 dias / semana)", value: 1.55, created_by_id: user.id)
ActivityFactor.create!(name: "Muy activo", description: "(ejercicio duro / deportes 6-7 dias a la semana)", value: 1.725, created_by_id: user.id)
ActivityFactor.create!(name: "Extra activo", description: "(ejercicio muy duro / deportes y trabajo fisico o entrenamiento 2x)", value: 1.9, created_by_id: user.id)
