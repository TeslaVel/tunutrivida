class CreatePayments < ActiveRecord::Migration[6.1]
  def change
    create_table :payments do |t|
      t.integer :status
      t.references :billing, null: false, foreign_key: true
      t.string :code

      t.timestamps
    end
  end
end
