class CreateIndicatorTypes < ActiveRecord::Migration[6.1]
  def change
    create_table :indicator_types do |t|
      t.text :name
      t.string :description
      t.references :created_by, null: false, foreign_key: { to_table: 'users' }, index: true

      t.timestamps
    end
  end
end
