class CreateNotification < ActiveRecord::Migration[6.1]
  def change
    create_table :notifications do |t|
      t.integer :notifcation_type, default: 0
      t.boolean :seen, default: false
      t.string :content, null: false
      t.integer :associated_object, null: false, index: true
      t.references :sender, null: false, foreign_key: { to_table: 'users' }, index: true
      t.references :recipient, null: false, foreign_key: { to_table: 'users' }, index: true

      t.timestamps
    end
  end
end
