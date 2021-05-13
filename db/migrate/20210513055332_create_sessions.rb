class CreateSessions < ActiveRecord::Migration[6.1]
  def change
    create_table :sessions do |t|
      t.decimal :weight, precision: 8, scale: 2
      t.decimal :height, precision: 8, scale: 2
      t.decimal :waist, precision: 8, scale: 2
      t.decimal :hip, precision: 8, scale: 2
      t.decimal :imc, precision: 8, scale: 2
      t.decimal :desired_imc, precision: 8, scale: 2
      t.date :date
      t.integer :dietitian_id
      t.references :patient, null: false, foreign_key: true

      t.timestamps
    end
  end
end
