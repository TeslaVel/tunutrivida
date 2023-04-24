# frozen_string_literal: true

# Create Migration Organization Member
class CreateOrganizationMemberships < ActiveRecord::Migration[6.1]
  def change
    create_table :organization_memberships do |t|
      t.references :user, index: true, null: false
      t.references :organization, index: true, null: false
      t.integer :is_admin, default: 0
      t.string :org_role, default: 'Standard'
      t.timestamps
    end
  end
end
