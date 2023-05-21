class CreateIndicators < ActiveRecord::Migration[6.1]
  def change
    create_table :indicators do |t|
      t.decimal :value_min, precision: 8, scale: 2
      t.decimal :value_max, precision: 8, scale: 2
      t.string :description
      t.string :name
      t.integer :position
      t.references :gender, null: false, foreign_key: true, index: true
      t.references :indicator_type, null: false, foreign_key: true, index: true
      t.references :created_by, foreign_key: { to_table: 'users' }, index: true


      t.timestamps
    end
  end
end
