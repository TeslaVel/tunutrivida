class CreateIndicators < ActiveRecord::Migration[6.1]
  def change
    create_table :indicators do |t|
      t.decimal :value_min, precision: 8, scale: 2
      t.decimal :value_max, precision: 8, scale: 2
      t.string :description
      t.integer :position
      t.references :gender, null: false, foreign_key: true
      t.references :indicator_type, null: false, foreign_key: true

      t.timestamps
    end
  end
end
