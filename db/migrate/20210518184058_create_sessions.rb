class CreateSessions < ActiveRecord::Migration[6.1]
  def change
    create_table :sessions do |t|
      t.decimal :weight, precision: 8, scale: 2
      t.decimal :height, precision: 8, scale: 2
      t.decimal :waist, precision: 8, scale: 2
      t.decimal :hip, precision: 8, scale: 2
      t.decimal :high_abdomen, precision: 8, scale: 2
      t.decimal :imc, precision: 8, scale: 2
      t.decimal :ideal_weight, precision: 8, scale: 2
      t.decimal :body_grease, precision: 8, scale: 2
      t.decimal :visceral_grease, precision: 8, scale: 2
      t.decimal :muscle_mass, precision: 8, scale: 2
      t.decimal :bone_mass, precision: 8, scale: 2
      t.integer :water_percentage, precision: 8, scale: 2
      t.integer :bmr
      t.integer :metabolic_age
      t.integer :physical_complexion

      t.date :date
      t.references :patient, null: false, foreign_key: true
      t.references :patient_package, null: false, foreign_key: true
      t.integer :dietitian_id
      t.integer :activity_factor_id
      # t.references :dietitian, null: false, foreign_key: true

      t.timestamps
    end
  end
end
