class CreateComments < ActiveRecord::Migration[6.1]
  def change
    create_table :comments do |t|
      t.text :message
      t.boolean :seen, default: false
      t.integer :comment_type, default: 0
      t.references :user, index: true, null: false
      t.integer :entry_id, index: true, null: true

      t.timestamps
    end
  end
end
