def create_patient_packages_and_sessions(patient, package, dietitian, height, days_week, date_base)
	puts "CREANDO PACIENTE PACKAGE FECHA:#{date_base}"
	h2 = (height*height).round(2)

	patient_package = PatientPackage.create(package: package, patient_id: patient.id, dietitian_id: dietitian.id, date: date_base)

	limite = package.weeks
	iterador = 0
	while iterador < limite
		puts "creating session #{( limite * days_week ) - (days_week * iterador)} days ago"
		created = date_base + (days_week * iterador).days
		puts "CREANDO SESSION FECHA:#{created}"
		weight = rand(50.20...60).round(2)
		high_abdomen = rand(60.3...65).round(2)
		low_abdomen = rand(50.3...61).round(2)
		waist = rand(60.3...67.2).round(2)
		hip = rand(50.3...57.5).round(2)
		imc = (weight / h2 ).round(2)
		body_grease = rand(10.3...15.90).round(2)
		visceral_grease = rand(8.3...11.90).round(2)
		muscle_mass = rand(10.1...22.90).round(2)
		bone_mass = rand(1.0...3.1),
		bmr = rand(1000...1600),
		metabolic_age = rand(30...45),
		water_percentage =  rand(30.2...40.5)
		physical_complexion = rand(1..4),
		ideal_weight = nil
		if iterador == 0
			ideal_weight = (imc * h2 )
		end

		Session.create!(
			age: patient.age,
			weight: weight,
			height: height,
			waist: waist,
			hip: hip,
			imc: imc,
			high_abdomen: high_abdomen,
			low_abdomen: low_abdomen,
			date: created,
			dietitian_id: dietitian.id,
			patient_id: patient.id,
			ideal_weight: ideal_weight,
			body_grease: body_grease,
			visceral_grease: visceral_grease,
			muscle_mass: muscle_mass,
			patient_package: patient_package,
			bone_mass:bone_mass,
			bmr: bmr,
			metabolic_age: metabolic_age,
			water_percentage: water_percentage,
			physical_complexion: physical_complexion,
			activity_factor_id: rand(1...3),
			created_by_id: dietitian.id
		)

		st = created.to_time > Time.now ? 0 : 1

		Appointment.create(
			start_date: created,
			time_start: created,
			time_end: created + dietitian.appointment_setting.time_step.minutes,
			status: st,
			dietitian_id: dietitian.id,
			patient_id: patient.id,
			appointment_type: Appointment::APPOINTMENT_TYPES.index(Appointment::APPOINTMENT_TYPES.sample).to_i
		)

		iterador += 1
	end
end

def get_username(value)
	"#{value.parameterize}#{Time.now.to_i.to_s(36)}#{SecureRandom.hex(1)}"
end

def patient_creator(idx, patient_data, dietitian, org, gpassword, days_week)
	patient = nil
	puts "Creating Patients #{idx+ 1}"
  created = Time.now - 14.days
  age = ((Time.zone.now - patient_data[:dob].to_time) / 1.year.seconds).floor
  username = get_username(patient_data[:first_name])
  patient = User.create(
            first_name: patient_data[:first_name],
            last_name: patient_data[:last_name],
            dietitian_id: dietitian.id,
            username: username,
            email: "#{username}@example.com",
            status: :active,
            gender: patient_data[:sex],
            age: age,
            date_of_birth: patient_data[:dob],
            organization_id: org.id,
            password: gpassword,
            password_confirmation: gpassword
            )
		patient.add_role :patient

		puts "Patient #{patient.first_name} Created."

		height = rand(1.50...1.90).round(2)

		patient_data[:packages].each_with_index do |pkg, indx|
			puts "Creating Patient Packages #{indx + 1}"
			if indx > 0
				date_base = (patient&.sessions&.first&.date || Time.now) - (days_week * pkg[:package].weeks ).days
			else
				date_base = Time.now - (days_week * pkg[:package].weeks ).days
			end

			create_patient_packages_and_sessions(patient, pkg[:package], dietitian, height, days_week, date_base)
		end
end

require_relative 'seed_scripts/create_admins_and_config'

return if Rails.env.production?

gpassword ='tunutrivida'

dietitian = User.find_by_email('tunutrividalb@gmail.com')
org = dietitian.organization

# Get female male etc as variable
# Create intances @female @male
Gender.all.each do |gender|
  variable_name = gender.name.downcase
  instance_variable_set("@#{variable_name}", gender)
end


# get packages as variables
Package.all.each_with_index do |pak, index|
  instance_variable_set("@package#{index}", pak)
end

@activity_factor1 = ActivityFactor.first

# create patients
y1 = 15
y2 = 70
days_week = 7

patient_data = [
	{
		first_name: 'Lucia',
		last_name: 'Mora',
		dob: Time.now - rand(y1...y2).years,
		sex: @female,
		packages: [{package: @package1}, {package: @package5}]
	},
	{
		first_name: 'Marina',
		last_name: 'Perdomo',
		dob: Time.now - rand(y1...y2).years,
		sex: @female,
		packages: [{package: @package2}]
	},
	{
		first_name: 'Marlon',
		last_name: Faker::Name.last_name,
		dob: Time.now - rand(y1...y2).years,
		sex: @male,
		packages: [{package: @package3}]
	},
	{
		first_name: 'Johnny',
		last_name: Faker::Name.last_name,
		dob: Time.now - rand(y1...y2).years,
		sex: @male,
		packages: [{package: @package4}]
	},
	{
		first_name: 'Mether',
		last_name: Faker::Name.last_name,
		dob: Time.now - rand(y1...y2).years,
		sex: @male,
		packages: [{package: @package3}, {package: @package5}]
	},
	{
		first_name: 'Leneu',
		last_name: Faker::Name.last_name,
		dob: Time.now - rand(y1...y2).years,
		sex: @male,
		packages: []
	},
	{
		first_name: Faker::Name.first_name,
		last_name: Faker::Name.last_name,
		dob: Time.now - rand(y1...y2).years,
		sex: [@female, @male].sample,
		packages: [
			{package: @package1},
			{package: @package2},
			{package: @package3},
			{package: @package4},
			{package: @package5},
		].take(rand(0...4))
	},
	{
		first_name: Faker::Name.first_name,
		last_name: Faker::Name.last_name,
		dob: Time.now - rand(y1...y2).years,
		sex: [@female, @male].sample,
		packages: [
			{package: @package1},
			{package: @package2},
			{package: @package3},
			{package: @package4},
			{package: @package5},
		].take(rand(0...4))
	},
	{
		first_name: Faker::Name.first_name,
		last_name: Faker::Name.last_name,
		dob: Time.now - rand(y1...y2).years,
		sex: [@female, @male].sample,
		packages: [
			{package: @package2},
			{package: @package3},
			{package: @package4},
			{package: @package5},
		].take(rand(0...4))
	}
]

patient_data.each_with_index do |ptn, idx|
  patient_creator(idx, ptn, dietitian, org, gpassword, days_week)
end

puts "Creating Patients Laura"
# Pactient Laura
dob = "1990-02-20".to_date
date_base = "2021-05-22".to_date
age = ((Time.zone.now - dob.to_time) / 1.year.seconds).floor
username = get_username('Laura')
patientL = User.create(
	first_name: 'Laura',
	last_name: 'Berrios',
	username: username,
	email: "#{username}@example.com",
	dietitian_id: dietitian.id,
	status: :active,
	gender: @female ,
	age: age,
	date_of_birth: dob,
	bmr_factor_source: 1,
	organization_id: org.id,
	password: gpassword,
	password_confirmation: gpassword
)
patientL.add_role :patient
puts "Patient #{patientL.first_name} Created."

patient_package = PatientPackage.create(package: @package5, patient: patientL, dietitian_id: dietitian.id, date: date_base)

created = date_base
height = 1.6
h2 = (height*height).round(2)
weight = 68.1
high_abdomen = 82.0
waist = 83.2
hip = 94.2
imc = (weight / h2 ).round(2)
body_grease = 35.5
visceral_grease = 5
muscle_mass = 41.7
water_percentage = 47.8
bone_mass = 2.2
bmr = 1358
metabolic_age = 46
physical_complexion = 2
ideal_weight = (imc * h2 )

Session.create!(
	weight: weight,height: height,
	waist: waist,hip: hip,
	imc: imc,
	high_abdomen: high_abdomen,
	low_abdomen: 0,
	date: created,
	dietitian_id: dietitian.id,
	patient_id: patientL.id,
	ideal_weight: ideal_weight,
	body_grease: body_grease,
	visceral_grease: visceral_grease,
	muscle_mass: muscle_mass,
	bone_mass: bone_mass,
	bmr: bmr,
	metabolic_age: metabolic_age,
	water_percentage: water_percentage,
	physical_complexion: physical_complexion,
	activity_factor_id: @activity_factor1.id,
	patient_package: patient_package,
	created_by_id: dietitian.id
)

created = "2022-08-29".to_date
height = 1.582
h2 = (height*height).round(2)
weight = 79.3
high_abdomen = 89
low_abdomen = 109.5
waist = 95.5
hip = 116
imc = (weight / h2 ).round(2)
body_grease = 40.3
visceral_grease = 7
muscle_mass = 45
water_percentage = 44.6
bone_mass = 2.4
bmr = 1475
metabolic_age = 62
physical_complexion = 3
ideal_weight = (imc * h2 )


Session.create!(
	weight: weight,height: height,
	waist: waist,hip: hip,
	imc: imc,
	high_abdomen: high_abdomen,
	low_abdomen: low_abdomen,
	date: created,
	dietitian_id: dietitian.id,
	patient_id: patientL.id,
	ideal_weight: ideal_weight,
	body_grease: body_grease,
	visceral_grease: visceral_grease,
	muscle_mass: muscle_mass,
	bone_mass: bone_mass,
	bmr: bmr,
	metabolic_age: metabolic_age,
	water_percentage: water_percentage,
	physical_complexion: physical_complexion,
	activity_factor_id: @activity_factor1.id,
	patient_package: patient_package,
	created_by_id: dietitian.id
)

created = "2022-09-04".to_date
height = 1.582
h2 = (height*height).round(2)
weight = 79.2
high_abdomen = 87
low_abdomen = 110
waist = 92
hip = 117
imc = (weight / h2 ).round(2)
body_grease = 42.6
visceral_grease = 7.5
muscle_mass = 43.2
water_percentage = 42.8
bone_mass = 2.3
bmr = 1433
metabolic_age = 69
physical_complexion = 2
ideal_weight = (imc * h2 )


Session.create!(
	weight: weight,height: height,
	waist: waist,hip: hip,
	imc: imc,
	high_abdomen: high_abdomen,
	low_abdomen: low_abdomen,
	date: created,
	dietitian_id: dietitian.id,
	patient_id: patientL.id,
	ideal_weight: ideal_weight,
	body_grease: body_grease,
	visceral_grease: visceral_grease,
	muscle_mass: muscle_mass,
	bone_mass: bone_mass,
	bmr: bmr,
	metabolic_age: metabolic_age,
	water_percentage: water_percentage,
	physical_complexion: physical_complexion,
	activity_factor_id: @activity_factor1.id,
	patient_package: patient_package,
	created_by_id: dietitian.id
)


created = "2023-03-28".to_date
height = 1.582
h2 = (height*height).round(2)
weight = 72.7
high_abdomen = 86.5
low_abdomen = 100.5
waist = 85
hip = 113.0
imc = (weight / h2 ).round(2)
body_grease = 39.3
visceral_grease = 7
muscle_mass = 27.2
water_percentage = nil
bone_mass = nil
bmr = nil
metabolic_age = 50
physical_complexion = nil
ideal_weight = (imc * h2 )

Session.create!(
	weight: weight,height: height,
	waist: waist,hip: hip,
	imc: imc,
	high_abdomen: high_abdomen,
	low_abdomen: low_abdomen,
	date: created,
	dietitian_id: dietitian.id,
	patient_id: patientL.id,
	ideal_weight: ideal_weight,
	body_grease: body_grease,
	visceral_grease: visceral_grease,
	muscle_mass: muscle_mass,
	bone_mass: bone_mass,
	bmr: bmr,
	metabolic_age: metabolic_age,
	water_percentage: water_percentage,
	physical_complexion: physical_complexion,
	activity_factor_id: @activity_factor1.id,
	patient_package: patient_package,
	created_by_id: dietitian.id
)

created = "2023-04-22".to_date
height = 1.582
h2 = (height*height).round(2)
weight = 71.4
high_abdomen = 82
low_abdomen = 96
waist = 83.2
hip = 94.2
imc = (weight / h2 ).round(2)
body_grease = 34.0
visceral_grease = 5
muscle_mass = 44.7
water_percentage = 49
bone_mass = 2.4
bmr = 1436
metabolic_age = 44
physical_complexion = 2
ideal_weight = (imc * h2 )

Session.create!(
	weight: weight,height: height,
	waist: waist,hip: hip,
	imc: imc,
	high_abdomen: high_abdomen,
	low_abdomen: low_abdomen,
	date: created,
	dietitian_id: dietitian.id,
	patient_id: patientL.id,
	ideal_weight: ideal_weight,
	body_grease: body_grease,
	visceral_grease: visceral_grease,
	muscle_mass: muscle_mass,
	bone_mass: bone_mass,
	bmr: bmr,
	metabolic_age: metabolic_age,
	water_percentage: water_percentage,
	physical_complexion: physical_complexion,
	activity_factor_id: @activity_factor1.id,
	patient_package: patient_package,
	created_by_id: dietitian.id
)


created = "2023-06-15".to_date
height = 1.582
h2 = (height*height).round(2)
weight = 70.2
high_abdomen = nil
low_abdomen = nil
waist = nil
hip = nil
imc = (weight / h2 ).round(2)
body_grease = 26.3
visceral_grease = 3.5
muscle_mass = 49.1
water_percentage = 54.8
bone_mass = 2.6
bmr = 1539
metabolic_age = 26
physical_complexion = 6
ideal_weight = (imc * h2 )

Session.create!(
	weight: weight,height: height,
	waist: waist,hip: hip,
	imc: imc,
	high_abdomen: high_abdomen,
	low_abdomen: low_abdomen,
	date: created,
	dietitian_id: dietitian.id,
	patient_id: patientL.id,
	ideal_weight: ideal_weight,
	body_grease: body_grease,
	visceral_grease: visceral_grease,
	muscle_mass: muscle_mass,
	bone_mass: bone_mass,
	bmr: bmr,
	metabolic_age: metabolic_age,
	water_percentage: water_percentage,
	physical_complexion: physical_complexion,
	activity_factor_id: @activity_factor1.id,
	patient_package: patient_package,
	created_by_id: dietitian.id
)


################################################### COMIENZO FRANCIS
puts "Creating Patients Francis"
# Pactient Francis
dob = "1988-03-03".to_date
date_base = "2023-03-23".to_date
now = Time.now.utc.to_date
age = now.year - dob.year - ((now.month > dob.month || (now.month == dob.month && now.day >= dob.day)) ? 0 : 1)
patientFran = User.create(
	first_name: 'Francis',
	last_name: 'Berrios',
	username: 'francisberrios',
	email: "francisberrios@example.com",
	dietitian_id: dietitian.id,
	status: :active,
	gender: @female,
	age: age,
	date_of_birth: dob,
	organization_id: org.id,
	password: gpassword,
	password_confirmation: gpassword
)
patientFran.add_role :patient
puts "Patient #{patientFran.first_name} Created."



# paquete uno francis
patient_package = PatientPackage.create(package: @package4, patient_id: patientFran.id, dietitian_id: dietitian.id, date: date_base)

puts "Creating Session 1 of Francis"
# session 1
created = "2023-03-23 ".to_date
height = 1.58
h2 = (height * height).round(2)
weight = 78.0
high_abdomen = 86.0
low_abdomen = 89.0
waist = 111.0
hip = 118.0
imc = (weight / h2 ).round(2)
body_grease = 42.7
visceral_grease = 8.0
muscle_mass = 25.7
water_percentage = nil
bone_mass = nil
bmr = nil
metabolic_age = 55
physical_complexion = nil
ideal_weight = (imc * h2 )


Session.create!(
	weight: weight,height: height,
	waist: waist,hip: hip,
	imc: imc,
	high_abdomen: high_abdomen,
	low_abdomen: low_abdomen,
	date: created,
	dietitian_id: dietitian.id,
	patient_id: patientFran.id,
	ideal_weight: ideal_weight,
	body_grease: body_grease,
	visceral_grease: visceral_grease,
	muscle_mass: muscle_mass,
	bone_mass: bone_mass,
	bmr: bmr,
	metabolic_age: metabolic_age,
	water_percentage: water_percentage,
	physical_complexion: physical_complexion,
	activity_factor_id: @activity_factor1.id,
	patient_package: patient_package,
	created_by_id: dietitian.id
)


puts "Creating Task Patient 1."
Task.create(
	title: "Lograr %10 ",
	description: "Rebajar el %10 de su peso acutal #{patientFran&.sessions&.first&.weight}",
	dietitian_id: dietitian.id,
	patient_id: patientFran.id
)

puts "Creating Session 2 of Francis"
# session 2
created = "2023-04-23 ".to_date
height = 1.58
h2 = (height*height).round(2)
weight = 77.3
high_abdomen = nil
low_abdomen = nil
waist = nil
hip = nil
imc = (weight / h2 ).round(2)
body_grease = nil
visceral_grease = nil
muscle_mass = nil
water_percentage = nil
bone_mass = nil
bmr = nil
metabolic_age = nil
physical_complexion = nil
ideal_weight = (imc * h2 )


Session.create!(
	weight: weight,height: height,
	waist: waist,hip: hip,
	imc: imc,
	high_abdomen: high_abdomen,
	low_abdomen: low_abdomen,
	date: created,
	dietitian_id: dietitian.id,
	patient_id: patientFran.id,
	ideal_weight: ideal_weight,
	body_grease: body_grease,
	visceral_grease: visceral_grease,
	muscle_mass: muscle_mass,
	bone_mass: bone_mass,
	bmr: bmr,
	metabolic_age: metabolic_age,
	water_percentage: water_percentage,
	physical_complexion: physical_complexion,
	activity_factor_id: @activity_factor1.id,
	patient_package: patient_package,
	created_by_id: dietitian.id
)

#### Creating some entries and comments
entry = Entry.create(
	description: 'Comiendo sano ahora yay!',
	user_id: patientFran.id,
	created_at: Time.zone.now - 1.days
)

Entry.create(
	description: 'Hoy de ejercicio!',
	user_id: patientL.id,
	entry_type: 2,
	created_at: Time.zone.now - 2.days
)

Comment.create(
	entry_id: entry.id,
	user_id: dietitian.id,
	comment_type: 1,
	message: '🎉'
)

require_relative 'seed_scripts/creare_ingredient_and_conditions'