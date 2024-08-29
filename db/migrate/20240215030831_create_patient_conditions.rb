class CreatePatientConditions < ActiveRecord::Migration[7.1]
  def change
    create_table :patient_conditions do |t|
      t.references :patient, null: false, foreign_key: { to_table: 'users' }, index: true
      t.references :condition, foreign_key: true
      t.references :created_by, null: false, foreign_key: { to_table: 'users' }, index: true
      t.timestamps
    end
  end
end
