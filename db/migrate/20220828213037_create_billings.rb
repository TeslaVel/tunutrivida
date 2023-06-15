class CreateBillings < ActiveRecord::Migration[6.1]
  def change
    create_table :billings do |t|
      t.decimal :total, precision: 8, scale: 2, default: 0
      t.decimal :sub_total, precision: 8, scale: 2, default: 0
      t.decimal :total_conversion, precision: 8, scale: 2, null: false, default: 0
      t.decimal :sub_total_conversion, precision: 8, scale: 2, null: false, default: 0
      t.decimal :target_conversion, precision: 8, scale: 2, null: false, default: 0
      t.string :target_currency, null: false, default: 'VES'
      t.string :target_currency_code, null: false, default: 'Bs'
      t.string :description
      t.string :code
      t.integer :billing_type, default: 0
      t.integer :status, default: 0

      # t.references :dietitian, foreign_key: { to_table: 'users' }, index: true
      # t.references :patient, null: false, foreign_key: true, index: true

      t.references :dietitian, null: false, foreign_key: { to_table: 'users' }, index: true
      t.references :patient, null: false, foreign_key: { to_table: 'users' }, index: true
      t.references :created_by, null: false, foreign_key: { to_table: 'users' }, index: true

      t.timestamps
    end
  end
end
