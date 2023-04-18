class BillingItems < ActiveRecord::Migration[6.1]
  def change
    create_table :billing_items do |t|
      t.string :description
      t.integer :item_type, default: 0
      t.integer :quantity, default: 1
      t.decimal :amount, precision: 8, scale: 2, default: 0
      t.decimal :total, precision: 8, scale: 2, default: 0

      t.decimal :total_conversion, precision: 8, scale: 2, null: false, default: 0
      t.decimal :target_conversion, precision: 8, scale: 2, null: false, default: 0
      t.string :target_currency, null: false, default: 'VES'
      t.string :target_currency_code, null: false, default: 'Bs'

      t.references :billing, null: false, foreign_key: true, index: true
      t.references :itemable, polymorphic: true, optional: true, index: true
      t.integer :status, default: 0
      t.timestamps
    end
  end
end