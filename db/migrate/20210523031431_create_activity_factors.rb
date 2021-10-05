class CreateActivityFactors < ActiveRecord::Migration[6.1]
  def change
    create_table :activity_factors do |t|
      t.string :name
      t.text :description
      t.decimal :value, precision: 8, scale: 3

      t.timestamps
    end
  end
end
