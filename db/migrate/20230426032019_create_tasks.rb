class CreateTasks < ActiveRecord::Migration[6.1]
  def change
    create_table :tasks do |t|
      t.string :title
      t.text :description
      t.integer :status, null: false, default: 0
      t.references :dietitian, null: false, foreign_key: { to_table: 'users' }, index: true
      t.references :patient, null: false, foreign_key: { to_table: 'users' }, index: true
      # t.references :patient, null: false, foreign_key: true

      t.timestamps
    end
  end
end
