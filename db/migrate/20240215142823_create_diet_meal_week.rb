class CreateDietMealWeek < ActiveRecord::Migration[7.1]
  def change
    create_table :diet_meal_weeks do |t|
      t.references :diet, foreign_key: true
      t.integer :day_of_week
      t.timestamps
    end
  end
end
