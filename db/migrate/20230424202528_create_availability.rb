class CreateAvailability < ActiveRecord::Migration[6.1]
  def change
    create_table :availabilities do |t|
      t.time :time_start
      t.time :time_end
      t.references :dietitian, null: false, foreign_key: { to_table: 'users' }, index: true

      t.timestamps
    end
  end
end
