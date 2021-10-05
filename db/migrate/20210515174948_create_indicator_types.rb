class CreateIndicatorTypes < ActiveRecord::Migration[6.1]
  def change
    create_table :indicator_types do |t|
      t.text :name
      t.string :description

      t.timestamps
    end
  end
end
