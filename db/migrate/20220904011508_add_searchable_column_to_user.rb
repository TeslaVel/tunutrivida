class AddSearchableColumnToUser < ActiveRecord::Migration[6.1]
  def up
    execute <<-SQL
      ALTER TABLE users
      ADD COLUMN searchable tsvector GENERATED ALWAYS AS (
        setweight(to_tsvector('english', coalesce(lower(first_name), '')), 'A') ||
        setweight(to_tsvector('english', coalesce(lower(last_name),'')), 'A')
      ) STORED;
    SQL
  end

  def down
    remove_column :users, :searchable
  end
end
