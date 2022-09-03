class CreateBillings < ActiveRecord::Migration[6.1]
  def change
    create_table :billings do |t|
      t.decimal :sub_total, precision: 8, scale: 2, default: 0
      t.decimal :total, precision: 8, scale: 2, default: 0
      t.string :description
      t.string :code
      t.integer :billing_type, default: 0

      t.references :dietitian, foreign_key: { to_table: 'users' }, index: true
      t.references :patient, null: false, foreign_key: true, index: true
      t.references :created_by, null: false, foreign_key: { to_table: 'users' }, index: true

      t.timestamps
    end
  end
end
