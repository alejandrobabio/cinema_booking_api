Sequel.migration do
  change do
    create_table(:bookings) do
      primary_key :id
      foreign_key :movie_id
      Date :booking_date
      String :customer_name
    end
  end
end
