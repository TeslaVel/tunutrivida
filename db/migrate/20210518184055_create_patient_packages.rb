class CreatePatientPackages < ActiveRecord::Migration[6.1]
  def change
    create_table :patient_packages do |t|
      t.references :package, null: false, foreign_key: true, index: true
      t.references :patient, null: false, foreign_key: { to_table: 'users' }, index: true
      # t.references :patient, null: false, foreign_key: true, index: true
      t.date :date
      t.integer :status, default: 0
      # t.references :dietitian, null: false, foreign_key: true
      # t.integer :dietitian_id, index: true
      t.references :dietitian, null: false, foreign_key: { to_table: 'users' }, index: true

      t.timestamps
    end
  end
end
