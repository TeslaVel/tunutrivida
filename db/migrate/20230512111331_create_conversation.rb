class CreateConversation < ActiveRecord::Migration[6.1]
  def change
    create_table :conversations do |t|
      t.references :dietitian, null: false, foreign_key: { to_table: 'users' }, index: true
      t.references :patient, null: false, foreign_key: { to_table: 'users' }, index: true
      t.string :title

      t.timestamps
    end
  end
end
