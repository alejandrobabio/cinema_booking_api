Sequel.migration do
  change do
    alter_table(:movies) do
      add_index(:name, unique: true)
    end
  end
end
