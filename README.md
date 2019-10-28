# Cinema Booking API

Try this API working in `https://cinema-booking-api.herokuapp.com`.

## Deployment

### Production deployment to Heroku

[![Deploy](https://www.herokucdn.com/deploy/button.svg)](https://heroku.com/deploy)

### Development and Test Setup

Clone de repository, run `bundle install` and copy `config/database.yml.example` to `config/database.yml`.

Create test and development databases, `user` should be consistent with your `config/database.yml`

```sh
$ createuser -U postgres cinema_booking
$ createdb -U postgres -O cinema_booking cinema_booking_test
$ createdb -U postgres -O cinema_booking cinema_booking_development
```

Run migrations

```sh
$ bundle exec dev_up
$ bundle exec test_up
```

Run tests

```sh
$ bundle exec rspec
```

Start the development server with `rerun` to get a server restart on any change of the source code:

```sh
$ rerun -- puma --port 3000 config.ru
```

Or, run bare server with:

```sh
$ puma --port 3000 config.ru
```

Then in development use the url: `http://localhost:3000` for all the endpoints.

## Endpoints

All the endpoints expect `json` format, that should be set in headers via: `Content-Type: application/json`. Response is sent in `json` format too.

### POST /movies

Create a new movie.

*Fields:*
- `name`: required, string
- `description`: optional, string
- `image_url`: optional, string, valid url for image
- `days`: required, array of strings, valid values: "Sun, Mon, Tue, Wed, Thu, Fri, Sat", defined by ruby `Date::ABBR_DAYNAMES`

*Example:*
```sh
curl -d '{"name":"Die Hard 3","days":["Mon","Sat"]}' \
  -H "Content-Type: application/json" \
  -X POST https://cinema-booking-api.herokuapp.com/movies
```

The API respond with status `201`, or `JSON` error message.

### GET /movies

List all movies for a given day. It requires one filter param: `day`, which is one of the values defined by `Date::ABBR_DAYNAMES`

*Example:*
```sh
curl -X GET 'https://cinema-booking-api.herokuapp.com/movies?day=Mon' \
  -H 'Content-Type: application/json'
```

The API respond with movies for that day, or error message if filter param is not correct.

*Response for the example:*
```json
[
  {
    "id": 1,
    "name": "Die Hard 3",
    "description": null,
    "days": [
      "Mon",
      "Sat"
    ],
    "image_url": null,
  }
]
```

### POST /bookings

Create a booking for a movie in a given date.

*Fields:*
- `booking_date`: required, string, format YYYY-MM-DD, should be in the future
- `movie_id`: required, integer, the movie should exists with this id
- `customer_name`: required, string

*Example:*
```sh
curl -d '{"booking_date":"2019-11-02","movie_id":1,"customer_name":"John Doe"}' \
 -H "Content-Type: application/json" \
 -X POST https://cinema-booking-api.herokuapp.com/bookings
```

The API respond with status `201`, or `JSON` error message.

### GET /bookings

List bookings between dates. It requires two filter params: `from` & `to`, that should be in format `YYYY-MM-DD`.

*Example:*
```sh
curl -H 'Content-Type: application/json' \
  -X GET 'https://cinema-booking-api.herokuapp.com/bookings?from=2019-11-01&to=2019-11-10'
```

The API responds with bookings between dates or error message if filter params are not correct.

*Response for the example:*
```json
[
  {
    "id": 1,
    "booking_date": "2019-11-02",
    "customer_name": "John Doe",
    "movie": {
      "id": 1,
      "name": "Die Hard 3",
      "description": null,
      "days": [
        "Mon",
        "Sat"
      ],
      "image_url": null,
    }
  }
]
```
