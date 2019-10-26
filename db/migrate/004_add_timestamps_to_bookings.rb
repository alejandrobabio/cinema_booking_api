Sequel.migration do
  change do
    alter_table(:bookings) do
      add_column :created_at, DateTime, default: Sequel::CURRENT_TIMESTAMP
      add_column :updated_at, DateTime, default: Sequel::CURRENT_TIMESTAMP
    end
  end
end
