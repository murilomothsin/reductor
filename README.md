# Reductor

The ultimate Shortener URL

## SETUP

* Install docker (https://docs.docker.com/install/)
* run `docker-compose build`
* run `docker volume create --name=postgres_database`
* run `docker-compose run web rake db:create`
* run `docker-compose run web rake db:migrate`
* run `docker-compose run web rake db:seed`
* run `docker-compose up`

# TO-DO

We are using the has_secure_token to generate the URL token... We need to update that for a tailored algorithm