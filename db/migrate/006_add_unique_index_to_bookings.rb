Sequel.migration do
  change do
    alter_table(:bookings) do
      add_index([:booking_date, :movie_id, :customer_name], unique: true)
    end
  end
end
