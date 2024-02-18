class CreateDietIngredients < ActiveRecord::Migration[7.1]
  def change
    create_table :diet_ingredients do |t|
      t.references :diet_meal_time, foreign_key: true
      t.references :meal, foreign_key: true
      t.string :instructions
      t.timestamps
    end
  end
end
