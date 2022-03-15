class CreateBillings < ActiveRecord::Migration[6.1]
  def change
    create_table :billings do |t|
      t.decimal :sub_total, precision: 8, scale: 2
      t.decimal :total, precision: 8, scale: 2
      t.string :code
      t.integer :billing_type, default: 0

      t.references :patient_package, null: false, foreign_key: true
      t.integer :dietitian_id, null: false

      t.timestamps
    end
  end
end
