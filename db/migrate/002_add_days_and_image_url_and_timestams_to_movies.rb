Sequel.migration do
  change do
    alter_table(:movies) do
      add_column :days, 'text[]'
      add_column :image_url, 'text'
      add_column :created_at, DateTime, default: Sequel::CURRENT_TIMESTAMP
      add_column :updated_at, DateTime, default: Sequel::CURRENT_TIMESTAMP
    end
  end
end

