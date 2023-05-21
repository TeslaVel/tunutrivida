class CreateBmrFactor < ActiveRecord::Migration[6.1]
  def change
    create_table :bmr_factors do |t|
      t.decimal :base_value, precision: 8, scale: 4
      t.decimal :base_height, precision: 8, scale: 4
      t.decimal :base_weight, precision: 8, scale: 4
      t.decimal :base_age, precision: 8, scale: 4
      t.string :name, null: true
      t.integer :position, null: false, default: 0
      t.integer :source, null: false, default: 1
      t.references :gender, null: false, foreign_key: true, index: true
      t.references :created_by, foreign_key: { to_table: 'users' }, index: true
      t.timestamps
    end
  end
end
