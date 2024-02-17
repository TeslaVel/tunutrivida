class CreateDietMealTime < ActiveRecord::Migration[7.1]
  def change
    create_table :diet_meal_times do |t|
      t.references :diet_meal_week, foreign_key: true
      t.integer :meal_time, default: 0
      t.timestamps
    end
  end
end
