class CreateEntries < ActiveRecord::Migration[6.1]
  def change
    create_table :entries do |t|
      t.text :description
      t.boolean :seen, default: false
      t.integer :entry_type, default: 0
      t.references :user, index: true, null: false

      t.timestamps
    end
  end
end
