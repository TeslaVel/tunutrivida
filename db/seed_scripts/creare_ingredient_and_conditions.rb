dietitian = User.second
patient = dietitian.patients.last

# Create conditions
puts 'creating conditions'
condition1 = Condition.create(name: 'Diabetes', description: 'Condición relacionada con el nivel de azúcar en la sangre.')
condition2 = Condition.create(name: 'Hipertensión', description: 'Condición relacionada con la presión arterial alta.')
condition3 = Condition.create(name: 'Alergia al gluten', description: 'Alergia a la proteína del gluten.')

# Create ingredients
# ingredient_type: 0 => simple
# ingredient_type: 0 => compund

puts 'creating ingredients'
#ingredient1 = 
Ingredient.create(name: 'Arroz con carne molida', ingredient_type: 0)
#ingredient2 = 
Ingredient.create(name: 'Pasticho', ingredient_type: 0)
#ingredient3 = 
Ingredient.create(name: 'Sopa de pollo', ingredient_type: 0)
#ingredient4 = 
Ingredient.create(name: 'Pure de papa', ingredient_type: 1)
#ingredient6 = 
Ingredient.create(name: 'Empanada Horneada', ingredient_type: 0)
ingredient7 = Ingredient.create(name: 'Cebada', ingredient_type: 0)
#ingredient8 = 
Ingredient.create(name: 'Caraotas', ingredient_type: 0)
#ingredient9 = 
Ingredient.create(name: 'Ensalada de remolacha', ingredient_type: 1)

Ingredient.create(name: 'Pure de calabaza', ingredient_type: 1)

Ingredient.create(name: 'Arroz con pollo', ingredient_type: 1)

RestrictedIngredientCondition.create(
  condition_id: condition3.id,
  ingredient_id: ingredient7.id
)

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

puts 'creating DietMealWeeks'

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
          ingredient_id: Ingredient.all.sample.id,
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