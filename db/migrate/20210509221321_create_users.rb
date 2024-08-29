class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :password_digest

      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :email, null: true, default: ''
      t.string :username, null: true, default: ''
      t.references :organization, index: true, null: true
      t.references :patient, index: true, null: true

      t.string :slug
      t.integer :age, null: true
      t.date :date_of_birth, null: true
      t.integer :gender_id, null: true
      t.integer :status, default: :active
      t.integer :bmr_factor_source, null: true, default: 1
      t.references :dietitian, null: true, foreign_key: { to_table: 'users' }, index: true

      t.timestamps
    end
  end
end
