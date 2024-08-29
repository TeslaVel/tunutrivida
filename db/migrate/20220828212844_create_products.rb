class CreateProducts < ActiveRecord::Migration[6.1]
  def change
    create_table :products do |t|
      t.string :name, null: false
      t.string :description
      t.string :code
      t.decimal :price, precision: 8, scale: 2, default: 0
      t.decimal :new_price, precision: 8, scale: 2, default: 0
      t.integer :status, default: 0
      t.references :created_by, foreign_key: { to_table: 'users' }, index: true

      t.timestamps
    end
  end
end
