class CreatePatientPackages < ActiveRecord::Migration[6.1]
  def change
    create_table :patient_packages do |t|
      t.references :package, null: false, foreign_key: true
      t.references :patient, null: false, foreign_key: true
      t.date :date
      t.boolean :status, default: false
      # t.references :dietitian, null: false, foreign_key: true
      t.integer :dietitian_id

      t.timestamps
    end
  end
end
