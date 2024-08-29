dietitian = User.second
patient = dietitian.patients.last

# Create conditions
puts 'creating conditions'
condition1 = Condition.create(name: 'Diabetes', description: 'Condición relacionada con el nivel de azúcar en la sangre.')
condition2 = Condition.create(name: 'Hipertensión', description: 'Condición relacionada con la presión arterial alta.')
condition3 = Condition.create(name: 'Alergia al gluten', description: 'Alergia a la proteína del gluten.')

# RestrictedIngredientCondition.create(
#   condition_id: condition3.id,
#   ingredient_id: Meal.first.id
# )

puts 'creating condition'
PatientCondition.create(
  created_by_id: dietitian.id,
  patient_id: patient.id,
  condition_id: condition3.id
)

puts 'creating Diets'
diet1 = Diet.create(
  name: 'Diet Plan 1',
  dietitian_id: dietitian.id,
  patient_id: patient.id,
  description: 'Esta es la diete que debe seguir de lunes-domingo'
)
diet2 = Diet.create(
  name: 'Diet Plan 2',
  dietitian_id: dietitian.id,
  patient_id: patient.id,
  description: 'Esta es la diete que debe seguir de lunes-domingo'
)



# Create Meals
# meal_type: 0 => simple
# meal_type: 0 => compund

desayunos = [
  {
    name: "Avena con frutas y semillas",
    meal_type: "compound",
    type_of_use: "breakfast",
    description: "Avena en hojuelas cocida con leche descremada o vegetal, arándanos, fresas, nueces picadas y semillas de chía."
  },

  {
    name: "Tostadas con aguacate",
    meal_type: "compound",
    type_of_use: "breakfast",
    description: "Tostadas integrales con aguacate, tomate y huevo pochado."
  },

  {
    name: "Batido de frutas con yogur",
    meal_type: "compound",
    type_of_use: "breakfast",
    description: "Batido de frutas con yogur natural, plátano, fresas, arándanos y espinacas."
  },

  {
    name: "Omelette de champiñones y espinacas",
    meal_type: "compound",
    type_of_use: "breakfast",
    description: "Omelette de claras de huevo con champiñones, espinacas y queso feta."
  },

  {
    name: "Panqueques integrales con miel y frutas",
    meal_type: "compound",
    type_of_use: "breakfast",
    description: "Panqueques integrales con miel, plátano y arándanos."
  },

  {
    name: "Smoothie bowl de granola y frutas",
    meal_type: "compound",
    type_of_use: "breakfast",
    description: "Smoothie bowl con granola, plátano, bayas y semillas de chía."
  },

  {
    name: "Yogur con frutas y frutos secos",
    meal_type: "compound",
    type_of_use: "breakfast",
    description: "Yogur natural con rodajas de kiwi, mango y almendras."
  },

  {
    name: "Huevos revueltos con espinacas y tomate",
    meal_type: "compound",
    type_of_use: "breakfast",
    description: "Huevos revueltos con espinacas, tomate y queso rallado."
  },

  {
    name: "Muffins de arándanos integrales",
    meal_type: "compound",
    type_of_use: "breakfast",
    description: "Muffins integrales de arándanos con copos de avena."
  },

  {
    name: "Burrito de desayuno con aguacate",
    meal_type: "compound",
    type_of_use: "breakfast",
    description: "Burrito de desayuno con huevo, aguacate, tomate y queso."
  },

  {
    name: "Cereal integral con leche y plátano",
    meal_type: "compound",
    type_of_use: "breakfast",
    description: "Cereal integral con leche descremada y rodajas de plátano."
  },

  {
    name: "Gachas de avena con frutas",
    meal_type: "compound",
    type_of_use: "breakfast",
    description: "Gachas de avena cocidas con leche, arándanos y almendras."
  },

  {
    name: "Bagel con salmón y queso crema",
    meal_type: "compound",
    type_of_use: "breakfast",
    description: "Bagel integral con salmón ahumado y queso crema."
  },

  {
    name: "Sandwich de aguacate y huevo pochado",
    meal_type: "compound",
    type_of_use: "breakfast",
    description: "Sandwich integral con aguacate, huevo pochado y espinacas."
  },

  {
    name: "Crepes de avena con frutas frescas",
    meal_type: "compound",
    type_of_use: "breakfast",
    description: "Crepes de avena rellenos de frutas frescas y yogur."
  }
]

almuerzos = [
  {
    name: "Ensalada de pollo a la parrilla",
    meal_type: "compound",
    type_of_use: "lunch",
    description: "Ensalada fresca con pechuga de pollo a la parrilla, lechuga, tomate, pepino y aderezo de limón."
  },

  {
    name: "Pasta integral con salsa de tomate y verduras",
    meal_type: "compound",
    type_of_use: "lunch",
    description: "Pasta integral con salsa de tomate casera, brócoli, zanahorias y champiñones."
  },

  {
    name: "Filete de salmón con quinoa y espárragos",
    meal_type: "compound",
    type_of_use: "lunch",
    description: "Filete de salmón al horno con quinoa cocida y espárragos asados."
  },

  {
    name: "Wrap de pollo con aguacate",
    meal_type: "compound",
    type_of_use: "lunch",
    description: "Wrap integral con tiras de pollo a la parrilla, aguacate, lechuga y salsa de yogur."
  },

  {
    name: "Arroz frito con verduras y tofu",
    meal_type: "compound",
    type_of_use: "lunch",
    description: "Arroz integral frito con verduras mixtas y tofu salteado."
  },

  {
    name: "Hamburguesa de garbanzos con ensalada",
    meal_type: "compound",
    type_of_use: "lunch",
    description: "Hamburguesa vegana de garbanzos con ensalada fresca y pan integral."
  },

  {
    name: "Tacos de pescado con repollo morado",
    meal_type: "compound",
    type_of_use: "lunch",
    description: "Tacos de pescado con repollo morado rallado, salsa de yogur y limón."
  },

  {
    name: "Quiche de espinacas y champiñones",
    meal_type: "compound",
    type_of_use: "lunch",
    description: "Quiche integral con espinacas, champiñones y queso rallado."
  },

  {
    name: "Bowl de arroz con frijoles y aguacate",
    meal_type: "compound",
    type_of_use: "lunch",
    description: "Bowl de arroz integral con frijoles negros, aguacate, maíz y cilantro."
  },

  {
    name: "Sándwich de pavo y queso",
    meal_type: "compound",
    type_of_use: "lunch",
    description: "Sándwich integral con pechuga de pavo, queso suizo, lechuga y tomate."
  },

  {
    name: "Pizza casera con vegetales",
    meal_type: "compound",
    type_of_use: "lunch",
    description: "Pizza integral con salsa de tomate, queso, champiñones, pimientos y espinacas."
  },

  {
    name: "Berenjenas rellenas de quinoa",
    meal_type: "compound",
    type_of_use: "lunch",
    description: "Berenjenas horneadas rellenas de quinoa, tomate, garbanzos y especias."
  },

  {
    name: "Curry de garbanzos con arroz basmati",
    meal_type: "compound",
    type_of_use: "lunch",
    description: "Curry vegano de garbanzos con verduras y arroz basmati."
  },

  {
    name: "Poke bowl de salmón y aguacate",
    meal_type: "compound",
    type_of_use: "lunch",
    description: "Poke bowl con dados de salmón fresco, aguacate, pepino y aderezo de soja."
  }
]

cenas = [
  {
    name: "Pechuga de pollo a la parrilla con quinoa",
    meal_type: "compound",
    type_of_use: "dinner",
    description: "Pechuga de pollo a la parrilla con quinoa cocida y espárragos asados."
  },

  {
    name: "Sopa de lentejas con espinacas",
    meal_type: "compound",
    type_of_use: "dinner",
    description: "Sopa reconfortante de lentejas con espinacas, zanahorias y tomate."
  },

  {
    name: "Tallarines integrales con albóndigas de pavo",
    meal_type: "compound",
    type_of_use: "dinner",
    description: "Tallarines integrales con albóndigas magras de pavo y salsa de tomate casera."
  },

  {
    name: "Ensalada de salmón ahumado y aguacate",
    meal_type: "compound",
    type_of_use: "dinner",
    description: "Ensalada fresca con salmón ahumado, aguacate, hojas verdes y aderezo de limón."
  },

  {
    name: "Estofado de garbanzos con espinacas",
    meal_type: "compound",
    type_of_use: "dinner",
    description: "Estofado saludable de garbanzos con espinacas, tomate y especias."
  },

  {
    name: "Brochetas de camarones y vegetales",
    meal_type: "compound",
    type_of_use: "dinner",
    description: "Brochetas coloridas con camarones, pimientos, cebolla y champiñones a la parrilla."
  },

  {
    name: "Pizza de coliflor con verduras",
    meal_type: "compound",
    type_of_use: "dinner",
    description: "Pizza saludable con base de coliflor, salsa de tomate, queso, y variedad de verduras."
  },

  {
    name: "Cazuela de pollo y quinoa",
    meal_type: "compound",
    type_of_use: "dinner",
    description: "Cazuela reconfortante de pollo, quinoa, zanahorias y caldo de pollo casero."
  },

  {
    name: "Hamburguesas vegetarianas con batatas asadas",
    meal_type: "compound",
    type_of_use: "dinner",
    description: "Hamburguesas vegetarianas con batatas asadas y una mezcla de hojas verdes."
  },

  {
    name: "Tacos de pescado con repollo y crema de aguacate",
    meal_type: "compound",
    type_of_use: "dinner",
    description: "Tacos de pescado con repollo rallado y crema de aguacate."
  },

  {
    name: "Pasta de lentejas con pesto de albahaca",
    meal_type: "compound",
    type_of_use: "dinner",
    description: "Pasta de lentejas con pesto fresco de albahaca, tomate y piñones."
  },

  {
    name: "Berenjenas a la parmesana con ensalada",
    meal_type: "compound",
    type_of_use: "dinner",
    description: "Berenjenas a la parmesana con ensalada fresca de hojas verdes."
  },

  {
    name: "Curry de garbanzos con arroz integral",
    meal_type: "compound",
    type_of_use: "dinner",
    description: "Curry delicioso de garbanzos con arroz integral y especias aromáticas."
  },

  {
    name: "Tortitas de avena con frutas frescas",
    meal_type: "compound",
    type_of_use: "dinner",
    description: "Tortitas saludables de avena con rodajas de frutas frescas y un toque de miel."
  }
]

puts 'creating desayunos'
desayunos.each do |meal|
  Meal.create(meal)
end

puts 'creating almuerzos'
almuerzos.each do |al|
  Meal.create(al)
end

puts 'creating cenas'
cenas.each do |al|
  Meal.create(al)
end

INSTRUCTIONS = [
  'Comer dializado',
  'Comer deshidratado',
  'Sancochaar antes de comer',
  'No sasonar con sal',
  'Sin azucar'
].freeze


[0, 1, 2, 3, 4, 5, 6].map do |wday|
  DietMealWeek.create(diet_id: diet1.id, day_of_week: wday).tap do |dmw|
    puts 'creating DietMealTimes'
    [0, 1, 2].map do |dtime|
      DietMealTime.create(meal_time: dtime, diet_meal_week_id: dmw.id).tap do |dmt|
        puts 'creating DietIngredient'
        DietIngredient.create(
          meal_id: Meal.all.sample.id,
          diet_meal_time_id: dmt.id,
          instructions: INSTRUCTIONS.sample
        )
      end
    end
  end
end

# diet_meal_week0 = DietMealWeek.create(diet_id: diet1.id, day_of_week: 0)
# diet_meal_week1 = DietMealWeek.create(diet_id: diet1.id, day_of_week: 1)
# diet_meal_week2 = DietMealWeek.create(diet_id: diet1.id, day_of_week: 2)
# diet_meal_week3 = DietMealWeek.create(diet_id: diet1.id, day_of_week: 3)
# diet_meal_week4 = DietMealWeek.create(diet_id: diet1.id, day_of_week: 4)
# diet_meal_week5 = DietMealWeek.create(diet_id: diet1.id, day_of_week: 5)
# diet_meal_week6 = DietMealWeek.create(diet_id: diet1.id, day_of_week: 6)




# diet_meal_time1 = DietMealTime.create(diet_id: diet1.id, meal_time: 0, diet_meal_week: diet_meal_week1)
# diet_meal_time2 = DietMealTime.create(diet_id: diet1.id, meal_time: 1, diet_meal_week: diet_meal_week1)
# diet_meal_time3 = DietMealTime.create(diet_id: diet1.id, meal_time: 2, diet_meal_week: diet_meal_week1)



# diet_ingredient1 = DietIngredient.create(ingredient_id: ingredient4.id, diet_meal_time_id: diet_meal_time1.id)
# diet_ingredient2 = DietIngredient.create(ingredient_id: ingredient9.id, diet_meal_time_id: diet_meal_time1.id)