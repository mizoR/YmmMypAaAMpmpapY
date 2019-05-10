# Mctsagsh

## Quickstart

1. Build app
    ```sh
    docker-compose build
    ```
2. Migrate DB
    ```sh
    docker-compose run web rails db:create
    docker-compose run web rails db:environment:set RAILS_ENV=development db:migrate
    ```
3. Run app
    ```sh
    docker-compose up
    ```
4. Open http://localhost:3000

🍻

## Test

1. Build app
    ```sh
    docker-compose build
    ```
2. Migrate DB
    ```sh
    docker-compose run web rails db:create
    docker-compose run web rails db:environment:set RAILS_ENV=test db:migrate
    ```
3. Run test
    ```sh
    docker-compose run web rspec ./spec
    ```

🍻

## API

You can see API document with http://localhost:3000/apipie

🍻
