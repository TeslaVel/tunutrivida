class CreateUserRoles < ActiveRecord::Migration[6.1]
  def change
    create_table :user_roles do |t|
      #t.references :dietitian, foreign_key: true
      t.references :user, foreign_key: true, index: true
      t.references :role, foreign_key: true, index: true
      t.references :created_by, null: true, foreign_key: { to_table: 'users' }, index: true

      t.timestamps
    end
  end
end
