class CreateGenders < ActiveRecord::Migration[6.1]
  def change
    create_table :genders do |t|
      t.string :name
      t.text :description
      t.integer :created_by_id, null: true, index: true

      t.timestamps
    end
  end
end
