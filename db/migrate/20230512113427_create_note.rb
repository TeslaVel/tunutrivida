class CreateNote < ActiveRecord::Migration[6.1]
  def change
    create_table :notes do |t|
      t.text :message, null: false
      t.references :conversation, null: false, index: true
      t.references :user, null: false, index: true

      t.timestamps
    end
  end
end
