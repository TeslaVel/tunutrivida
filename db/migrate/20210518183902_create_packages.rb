class CreatePackages < ActiveRecord::Migration[6.1]
  def change
    create_table :packages do |t|
      t.string :name
      t.string :description
      t.integer :weeks
      t.decimal :price, precision: 8, scale: 2

      t.timestamps
    end
  end
end
