class CreateAppointments < ActiveRecord::Migration[6.1]
  def change
    create_table :appointments do |t|
      t.date :start_date
      t.time :time_start
      t.time :time_end
      t.integer :status, null: false, default: 0
      t.references :dietitian, null: false, foreign_key: { to_table: 'users' }, index: true
      t.references :patient, null: false, foreign_key: { to_table: 'users' }, index: true
      # t.references :patient, null: false, foreign_key: true
      t.integer :appointment_type, null: false, default: 0
      t.string :title, null: true, default: ''

      t.timestamps
    end
  end
end
