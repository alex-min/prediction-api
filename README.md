# Prediction API

This project is part of the team prediction API, build with RubyOnRails.
The main goal is to provide two teams to the api which returns the probability of the first team winning.

There are only two endpoints at the moment:

- ```GET /healthcheck``` Always returns "ok", can be used in production to spawn another instance if the healthcheck does not answer.
- ```GET /api/prediction?teams[]=first_team&teams[]=second_team``` This endpoint returns the probability as a number of the first team winning. If the call succeed, the HTTP status will be 200.

## Project setup

The project is can be locally setup with [docker-compose](https://docs.docker.com/compose/) and [docker](https://docs.docker.com) locally.

Run:

```shell
docker-compose up
```
in the project directory to get started. The backend is then accessible on port 9001.

API usage example:
```shell
$ curl http://localhost:9001/healthcheck
"ok"
$ curl http://localhost:9001/api/prediction?teams[]=Virtus.pro&teams[]=Ninjas%20in%20Pyjamas
24
```

## Tests

Tests are using [RSpec](http://rspec.info/) and are located in the spec/ directory.
To run them locally, please execute

```
docker-compose run web bundle exec rspec
```

## Setup on production

To run the application in production, the api can be setup with Docker or locally.


To setup localy the application, ruby-2.4.1, bundle and build-essentials (or equivalent depending on the distribution) are required.

 
Some additional environement variable should be setup in production:
```
SECRET_KEY_BASE=please generate this token by executing 'rails secret'
RAILS_ENV=production
```

The endpoint ```/healthcheck``` can be used to restart the application if needed or create new instances. On AWS, it can be configured with the ELB to be used as the healthcheck, thus creating a new instance if the API fails.

## Prediction algorithm

The prediction algorithm is working according to the [paper](docs/api_paper.pdf) the docs/ folder.

The algorithm is using the default sentence ```DEFEATS```, this sentense can be changed with the environment variable  ```PREDICTION_SENTENCE```.

Because the algorithm is not guaranteed to generate a result, a ```PREDICTION_MAX_CYCLE``` environment variable has been introduced to avoid the API to hang up, it defaults to 20.

## Folder architecture

The project is using the [standard Rails folder architecture](https://www.tutorialspoint.com/ruby-on-rails/rails-directory-structure.htm). The api endpoint is located in controllers/api and new api endpoints can be added under the [config/routes.yml](config/routes.yml) files using the ```:api``` namespace.

