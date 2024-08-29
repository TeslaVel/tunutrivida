class CreatePackages < ActiveRecord::Migration[6.1]
  def change
    create_table :packages do |t|
      t.string :name
      t.string :description
      t.integer :weeks, default: 0
      t.integer :session_quantity, default: 0
      t.decimal :price, precision: 8, scale: 2
      t.integer :status, default: 0
      t.integer :position, default: 0
      t.references :created_by, null: false, foreign_key: { to_table: 'users' }, index: true

      t.timestamps
    end
  end
end
