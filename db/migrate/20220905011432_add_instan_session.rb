class AddInstanSession < ActiveRecord::Migration[6.1]
  def change
    create_table :instant_sessions do |t|
      t.decimal :weight, precision: 8, scale: 2
      t.decimal :height, precision: 8, scale: 2
      t.decimal :waist, precision: 8, scale: 2
      t.decimal :hip, precision: 8, scale: 2
      t.decimal :high_abdomen, precision: 8, scale: 2
      t.decimal :low_abdomen, precision: 8, scale: 2
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
      t.integer :gender_id, null: false
      t.date :date
      t.integer :activity_factor_id
      t.references :created_by, null: false, foreign_key: { to_table: 'users' }, index: true

      t.timestamps
    end
  end
end
