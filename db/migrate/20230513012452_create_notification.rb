class CreateNotification < ActiveRecord::Migration[6.1]
  def change
    create_table :notifications do |t|
      t.integer :notification_type, default: 0
      t.boolean :seen, default: false
      t.string :content, null: false
      t.references :associated_object, polymorphic: true, optional: true, index: true
      t.references :sender, null: true, foreign_key: { to_table: 'users' }, index: true
      t.references :recipient, null: true, foreign_key: { to_table: 'users' }, index: true

      t.timestamps
    end
  end
end
