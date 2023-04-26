class CreateAppointmentSetting < ActiveRecord::Migration[6.1]
  def change
    create_table :appointment_settings do |t|
      t.references :dietitian, null: false, foreign_key: { to_table: 'users' }, index: true
      t.integer :time_step, null: false, default: 5
      t.timestamps
    end
  end
end
