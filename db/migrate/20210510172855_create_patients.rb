class CreatePatients < ActiveRecord::Migration[6.1]
  def change
    create_table :patients do |t|
      t.string :first_name
      t.string :last_name
      t.string :slug
      t.integer :age
      t.date :date_of_bird
      t.integer :gender_id, null: false
      t.references :dietitian, null: false, foreign_key: { to_table: 'users' }, index: true
      t.integer :status, default: :active

      t.timestamps
    end
  end
end
