### Database Setup

Create test and development databases, `user` should be consistent with your `config/database.yml`

```shell
$ createuser -U postgres cinema_booking
$ createdb -U postgres -O cinema_booking cinema_booking_test
$ createdb -U postgres -O cinema_booking cinema_booking_development
```


