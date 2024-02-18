class CreateMeals < ActiveRecord::Migration[7.1]
  def change
    create_table :meals do |t|
      t.string :name
      t.integer :type_of_use, default: 0
      t.integer :meal_type, default: 0
      t.string :description
      t.timestamps
    end
  end
end
