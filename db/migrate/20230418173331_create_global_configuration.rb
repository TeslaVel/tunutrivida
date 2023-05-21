class CreateGlobalConfiguration < ActiveRecord::Migration[6.1]
  def change
    create_table :global_configurations do |t|
      t.string :currency, null: false, default: 0
      t.string :currency_code, null: false, default: 0
      t.string :target_currency, null: false, default: 1
      t.string :target_currency_code, null: false, default: 0
      t.decimal :target_conversion, precision: 8, scale: 2, default: 1
      t.integer :bmr_source, null: false, default: 1

      t.references :created_by, null: false, foreign_key: { to_table: 'users' }, index: true

      t.timestamps
    end
  end
end
