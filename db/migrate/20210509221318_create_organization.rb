# frozen_string_literal: true

# Create Migration CreateOrganization
class CreateOrganization < ActiveRecord::Migration[6.1]
  def change
    create_table :organizations do |t|
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end
