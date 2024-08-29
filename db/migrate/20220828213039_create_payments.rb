class CreatePayments < ActiveRecord::Migration[6.1]
  def change
    create_table :payments do |t|
      t.string :code
      t.integer :status, default: 0
      t.references :dietitian, null: false, foreign_key: { to_table: 'users' }, index: true
      t.references :billing, null: false, foreign_key: true, index: true
      t.references :created_by, null: false, foreign_key: { to_table: 'users' }, index: true

      t.timestamps
    end
  end
end
