# Places API

Building an API using Ruby on Rails 6.

<table>
  <tr>
    <td>Ruby Version</td>
    <td>2.5.8</td>
  </tr>
  <tr>
    <td>Rails Version</td>
    <td>6.0.4.6</td>
  </tr>
  <tr>
    <td>Database</td>
    <td>PostgreSQL</td>
  </tr>
</table>

## Installation

```bash
  # clone the project
  git clone https://github.com/karinevieira/places-api.git

  # enter the cloned directory
  cd places-api

  # run the project
  docker-compose up --build

  # create the development and test databases
  rails db:create

  # migrate tables to database
  rails db:migrate
```
Open the browser at the address http://localhost:3000 

## Running Tests

To run tests, run the following command

```bash
  rspec
```

## API Reference

#### Include a Header Authorization

For all requests, use an Authorization header, of size >= 10 characters, so that you can only manipulate your data, for example:

```bash
  curl --request GET \
  --url 'http://localhost:3000/api/places' \
  --header 'Authorization: anyTokenCanBeUsed'
```

#### Endpoints

| Endpoints                 | Usage                                  | Params                                          |
|---------------------------|----------------------------------------|-------------------------------------------------|
| ``GET /api/places``           | Get all of the places.                 |                                                 |
| ``GET /api/places?name=term`` | Get all places with name like term.    | term: [String]                                  |
| ``GET /api/places/:id``       | Get details of a single place.         |                                                 |
| ``POST /api/places``          | Create a new place.                    | name: [String], city: [String], state: [String] |
| ``PUT /api/places/:id``       | Edit the details of an existing place. | name: [String], city: [String], state: [String] |
| ``DELETE /api/places/:id``    | Remove the place.                      |                                                 |
