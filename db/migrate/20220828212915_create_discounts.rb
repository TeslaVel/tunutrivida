class CreateDiscounts < ActiveRecord::Migration[6.1]
  def change
    create_table :discounts do |t|
      t.string :name, null: false
      t.string :description
      t.integer :discount_type, default: 0
      t.decimal :amount, precision: 8, scale: 2, default: 0
      t.integer :status, default: 0
      t.references :created_by, null: false, foreign_key: { to_table: 'users' }, index: true

      t.timestamps
    end
  end
end
