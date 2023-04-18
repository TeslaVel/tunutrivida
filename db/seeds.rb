public
	def create_patient_packages_and_sessions(patient,package,dietitian,height,days_week,date_base)

		h2 = (height*height).round(2)

		patient_package =PatientPackage.create(package: package, patient: patient, dietitian_id: dietitian.id, date: date_base)

		limite = package.weeks
		iterador = 0
		while iterador < limite
		  puts "creating session #{( limite * days_week ) - (days_week * iterador)} days ago"
			created = date_base + (days_week * iterador).days
			weight = rand(50.20...60).round(2)
			high_abdomen = rand(60.3...65).round(2)
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
				weight: weight,height: height,
				waist: waist,hip: hip,
				imc: imc,
				high_abdomen: high_abdomen, date: created,
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
		  iterador += 1
		end

	end

private

	user = User.create!(
		email: 'm3taljose@gmail.com',
		username: 'm3taljose',
		first_name: 'Admin 1',
		last_name: 'Admin 1',
		password: '2351310',
		password_confirmation: '2351310'
	)
	puts "Created admin: #{user.email}"

	dietitian = User.create!(
		email: 'tunutrividalb@gmail.com',
		username: 'tunutrividalb',
		first_name: "Laura",
		last_name: "Berrios",
		password: '2351310',
		password_confirmation: '2351310'
	)
	puts "Created dietitian: #{dietitian.email}"

	role_dietitian = Role.create(name: 'dietitian', description: "Dietitian", created_by_id: user.id)
	role_amin = Role.create(name: 'super_admin', description: "Super Admin", created_by_id: user.id)
	role_patient = Role.create(name: 'patient', description: "Patient", created_by_id: user.id)
	puts "Created roles: #{role_dietitian.name}, #{role_amin.name}, #{role_patient.name}"

	UserRole.create(user:user ,role: role_dietitian, created_by_id: user.id)
	UserRole.create(user:user ,role: role_amin, created_by_id: user.id)
	UserRole.create(user: dietitian ,role: role_dietitian, created_by_id: user.id)
	puts "Asigned Roles"


	puts "Creating GlobalConfiguration"
	glb = GlobalConfiguration.create(
		currency: 'USD',
		currency_code: "$",
		target_currency: 'VES',
		target_currency_code: 'Bs',
		target_conversion: '24.45',
		created_by_id: 1
	)

	puts "Creating Genders"
	male = Gender.create(name: "Male", description: "Male", created_by_id: user.id)
	female = Gender.create(name: "Female", description: "Female", created_by_id: user.id)
	other = Gender.create(name: "Ohter", description: "Ohter", created_by_id: user.id)
	both = Gender.create(name: "Both", description: "Both", created_by_id: user.id)

	puts "Creating IndicatorTypes"
	typeImc = IndicatorType.create(name:"IMC", description: "IMC", created_by_id: user.id)
	typePdc = IndicatorType.create(name:"PDC", description: "Perimetro de cintura", created_by_id: user.id)
	typeIcc = IndicatorType.create(name:"ICC", description: "Indice cintura cadera ", created_by_id: user.id)

	puts "Creating Indicators"
	Indicator.create(value_min: 0.0, value_max: 18.4 , description: 'Bajo peso', gender: both, position: 1, indicator_type: typeImc, created_by_id: user.id)
	Indicator.create(value_min: 18.41, value_max: 24.9 , description: 'Normo peso', gender: both, position: 2, indicator_type: typeImc, created_by_id: user.id)
	Indicator.create(value_min: 25.0, value_max: 29.9 , description: 'Sobre Peso', gender: both, position: 3, indicator_type: typeImc, created_by_id: user.id)
	Indicator.create(value_min: 30.0, value_max: 34.9 , description: 'Obesidad I', gender: both, position: 4, indicator_type: typeImc, created_by_id: user.id)
	Indicator.create(value_min: 35.0, value_max: 39.9 , description: 'Obesidad II', gender: both, position: 5, indicator_type: typeImc, created_by_id: user.id)
	Indicator.create(value_min: 40, value_max: 999 , description: 'Obesidad morbida', gender: both, position: 6, indicator_type: typeImc, created_by_id: user.id)

	Indicator.create(value_min: 0.0, value_max: 80 , description: 'Bajo', gender: female, position: 1, indicator_type: typePdc, created_by_id: user.id)
	Indicator.create(value_min: 80, value_max: 88.1 , description: 'Aumentado', gender: female, position: 2, indicator_type: typePdc, created_by_id: user.id)
	Indicator.create(value_min: 88.0, value_max: 999 , description: 'Aumentado', gender: female, position: 2, indicator_type: typePdc, created_by_id: user.id)

	#compara cintura
	Indicator.create(value_min: 0.0, value_max: 94 , description: 'Bajo', gender: male, position: 1, indicator_type: typePdc, created_by_id: user.id)
	Indicator.create(value_min: 94.0, value_max: 102.1 , description: 'Aumentado', gender: male, position: 2, indicator_type: typePdc, created_by_id: user.id)
	Indicator.create(value_min: 102.0, value_max: 999 , description: 'Aumentado', gender: male, position: 3, indicator_type: typePdc, created_by_id: user.id)

	#icc cintura / cadera
	Indicator.create(value_min: 0.0, value_max: 0.80 , description: 'Sin riesgo', gender: female, position: 1, indicator_type: typeIcc, created_by_id: user.id)
	Indicator.create(value_min: 0.80, value_max: 999 , description: 'Con Riesgo', gender: female, position: 2, indicator_type: typeIcc, created_by_id: user.id)

	Indicator.create(value_min: 0.0, value_max: 0.9 , description: 'Sin riesgo', gender: male, position: 1, indicator_type: typeIcc, created_by_id: user.id)
	Indicator.create(value_min: 0.9, value_max: 999 , description: 'Con Riesgo', gender: male, position: 2, indicator_type: typeIcc, created_by_id: user.id)

	puts "Creating Packages"
	package0 = Package.create!(name: "Empty Package", description: "Paquete Vacio", price: 0, weeks: 0, created_by_id: user.id)
	package1 = Package.create!(name: "Paquete 1 semanas", description: "Paquete que incluye tal y tal", price: 21.00, weeks: 1, created_by_id: user.id)
	package2 = Package.create!(name: "Paquete 2 semanas", description: "Paquete que incluye tal y tal", price: 36.80, weeks: 2, created_by_id: user.id)
	package3 = Package.create!(name: "Paquete 3 semanas", description: "Paquete que incluye tal y tal", price: 60, weeks: 3, created_by_id: user.id)
	package4 = Package.create!(name: "Paquete 4 semanas", description: "Paquete que incluye tal y tal", price: 81.50, weeks: 4, created_by_id: user.id)
	package5 = Package.create!(name: "Paquete 5 semanas", description: "Paquete que incluye tal y tal", price: 126.00, weeks: 5, created_by_id: user.id)

	puts "Creating ActivityFactor"
	activity_factor1 = ActivityFactor.create!(name: "Sedentario", description: "(poco o ningun ejercicio)", value: 1.2, created_by_id: user.id)
	activity_factor2 = ActivityFactor.create!(name: "Ligeramente activo", description: "(ejercicio ligero / deportes 1-3 dias / semana)", value: 1.375, created_by_id: user.id)
	activity_factor3 = ActivityFactor.create!(name: "Moderadamente activo", description: "(ejercicio moderado / deportes 3-5 dias / semana)", value: 1.55, created_by_id: user.id)
	activity_factor4 = ActivityFactor.create!(name: "Muy activo", description: "(ejercicio duro / deportes 6-7 dias a la semana)", value: 1.725, created_by_id: user.id)
	activity_factor5 = ActivityFactor.create!(name: "Extra activo", description: "(ejercicio muy duro / deportes y trabajo fisico o entrenamiento 2x)", value: 1.9, created_by_id: user.id)


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


	y1=15
	y2=70
	gender = rand(1..2)
	days_week = 7


	puts "Creating Patients 1"
	# Pactient 1
	dob =Time.now - rand(y1...y2).years
	created = Time.now - 14.days
	age = ((Time.zone.now - dob.to_time) / 1.year.seconds).floor
	patient1 = Patient.create(first_name: "Lucia",
														last_name: "Mora",
														dietitian_id: dietitian.id,
														gender: female ,
														date_of_bird: dob ,
														age: age)
	puts "Patient #{patient1.first_name} Created."

	height = rand(1.50...1.90).round(2)
	date_base = Time.now - (days_week * package1.weeks ).days
	puts "Creating Patieng Package 1."
	create_patient_packages_and_sessions(patient1,package1,dietitian,height,days_week,date_base)

	puts "Creating Patients 2"
	# Pactient 2
	dob =Time.now - rand(y1...y2).years
	created = Time.now - 14.days
	age = ((Time.zone.now - dob.to_time) / 1.year.seconds).floor
	patient2 = Patient.create(first_name: "Marina", last_name: "Perdomo", dietitian_id: dietitian.id, gender: female , date_of_bird: dob, age: age)
	puts "Patient #{patient2.first_name} Created."


	height = rand(1.50...1.90).round(2)
	date_base = Time.now - (days_week * package2.weeks ).days
	create_patient_packages_and_sessions(patient2,package2,dietitian,height,days_week,date_base)

	puts "Creating Patients 3"
	# Pactient 3
	dob =Time.now - rand(y1...y2).years
	age = ((Time.zone.now - dob.to_time) / 1.year.seconds).floor
	patient3 = Patient.create(first_name: Faker::Name.name, last_name: Faker::Name.last_name, dietitian_id: dietitian.id, gender: female , date_of_bird: dob, age: age)
	puts "Patient #{patient3.first_name} Created."

	height = rand(1.50...1.90).round(2)
	date_base = Time.now - (days_week * package3.weeks ).days
	create_patient_packages_and_sessions(patient3,package3,dietitian,height,days_week,date_base)

	puts "Creating Patients 4"
	# Pactient 4
	dob =Time.now - rand(y1...y2).years
	created = Time.now - 14.days
	age = ((Time.zone.now - dob.to_time) / 1.year.seconds).floor
	patient4 = Patient.create(first_name: Faker::Name.name, last_name: Faker::Name.last_name, dietitian_id: dietitian.id, gender: female , date_of_bird: dob, age: age)
	puts "Patient #{patient4.first_name} Created."

	height = rand(1.50...1.90).round(2)
	date_base = Time.now - (days_week * package4.weeks ).days
	create_patient_packages_and_sessions(patient4,package4,dietitian,height,days_week,date_base)

	puts "Creating Patients 5"
	# Pactient 5 with two packages
	dob =Time.now - rand(y1...y2).years
	age = ((Time.zone.now - dob.to_time) / 1.year.seconds).floor
	patient5 = Patient.create(first_name: Faker::Name.name, last_name: Faker::Name.last_name, dietitian_id: dietitian.id, gender: female , date_of_bird: dob, age: age)
	puts "Patient #{patient5.first_name} Created."

	height = rand(1.50...1.90).round(2)
	# primer paquete 
	date_base = Time.now - (days_week * package3.weeks ).days
	create_patient_packages_and_sessions(patient5,package3,dietitian,height,days_week,date_base)

	# segundo paquete
	date_base = date_base - (days_week * package5.weeks ).days
	create_patient_packages_and_sessions(patient5,package5,dietitian,height,days_week,date_base)

	puts "Creating Patients 6"
	# Pactient 6 with 0 packages
	dob =Time.now - rand(y1...y2).years
	created = Time.now - 14.days
	age = ((Time.zone.now - dob.to_time) / 1.year.seconds).floor
	patient6 = Patient.create(first_name: Faker::Name.name, last_name: Faker::Name.last_name, dietitian_id: dietitian.id, gender: female , date_of_bird: dob, age: age)
	puts "Patient #{patient6.first_name} Created."

	puts "Creating Patients Laura"
	# Pactient Laura
	dob = "1990-02-20".to_date
	date_base = "2021-05-22".to_date
	age = ((Time.zone.now - dob.to_time) / 1.year.seconds).floor
	patientL = Patient.create(first_name: "Laura", last_name: "Berrios", dietitian_id: dietitian.id, gender: female , date_of_bird: dob, age: age)
	puts "Patient #{patientL.first_name} Created."

	patient_package =PatientPackage.create(package: package5, patient: patientL, dietitian_id: dietitian.id, date: date_base)

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
		activity_factor_id: activity_factor1.id,
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
		activity_factor_id: activity_factor1.id,
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
		activity_factor_id: activity_factor1.id,
		patient_package: patient_package,
		created_by_id: dietitian.id
	)