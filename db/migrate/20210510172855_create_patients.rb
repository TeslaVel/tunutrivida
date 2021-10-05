class CreatePatients < ActiveRecord::Migration[6.1]
  def change
    create_table :patients do |t|
      t.string :first_name
      t.string :last_name
      t.string :slug
      t.integer :age
      t.date :date_of_bird
      # t.references :dietitian, foreign_key: true
      t.integer :gender_id, null: false
      t.integer :dietitian_id, null: false

      t.timestamps
    end
  end
end
