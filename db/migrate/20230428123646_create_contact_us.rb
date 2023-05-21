class CreateContactUs < ActiveRecord::Migration[6.1]
  def change
    create_table :contact_us do |t|
      t.string :email
      t.boolean :seen, default: false
      t.references :read_by, null: true, foreign_key: { to_table: 'users' }, index: true
      t.string :first_name
      t.string :last_name
      t.string :string
      t.text :message

      t.timestamps
    end
  end
end
