class CreateRestrictedIngredientConditions < ActiveRecord::Migration[7.1]
  def change
    create_table :restricted_ingredient_conditions do |t|
      t.references :meal, foreign_key: true
      t.references :condition, foreign_key: true
      t.timestamps
    end
  end
end
