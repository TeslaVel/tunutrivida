class CreateDiets < ActiveRecord::Migration[7.1]
  def change
    create_table :diets do |t|
      t.string :name
      t.string :description
      t.references :dietitian, null: false, foreign_key: { to_table: 'users' }, index: true
      t.references :patient, null: false, foreign_key: { to_table: 'users' }, index: true
      t.references :session, null: true, foreign_key: true, index: true
      t.timestamps
    end
  end
end
