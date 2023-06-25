# Space Code Platform

Welcome to the Space Code Platform! This platform allows you to manage space travel contracts, pilots, ships, and more.
You can set up the platform either with Docker or locally. Choose the method that suits your preferences and requirements.

## Set Up with Docker

To set up the Space Code Platform using Docker, follow these steps:

1. Install Docker on your machine if you haven't already. Refer to the Docker documentation for detailed installation instructions: [https://docs.docker.com/get-docker/](https://docs.docker.com/get-docker/)

2. Clone the Space Code Platform repository from GitHub:

```git clone git@github.com:cboliveiras/space-code-platform.git```

3. If you don't have access to the Github repository, download the .zip file and proceed to step 4.

4. Navigate to the project directory:

```cd space-code-platform```

5. Build the Docker image:

```docker-compose build```

6. Run the Docker container:

```docker-compose up```

7. Create the database, run the migrations and create the seeds:

```docker-compose run web rake db:drop db:create db:migrate db:seed```

8. The Space Code Platform should now be accessible at [http://localhost:3000](http://localhost:3000)

9. Run the tests:

```docker-compose run web rake spec PGUSER=postgres RAILS_ENV=test```

10. If you want, open a bash session inside the container:

```docker exec -it space-code-platform_web_1 bash```

## Set Up Locally

To set up the Space Code Platform locally, follow these steps:

1. Install Ruby 2.7.4 or later on your machine. You can use a version manager like RVM or rbenv to manage your Ruby installations.

2. Clone the Space Code Platform repository from GitHub:

```git clone git@github.com:cboliveiras/space-code-platform.git```

3. If you don't have access to the Github Repository, download the .zip file and proceed to step 4.

4. Navigate to the project directory:

```cd space-code-platform```

5. Install the required gems:

```bundle install```

6. The database.yml file is originally configured to use Docker. If you want to run the application locally, you have to update to:

```
default: &default
  adapter: postgresql
  encoding: unicode

development:
  <<: *default
  database: space-code-platform_development

test:
  <<: *default
  database: space-code-platform_test
```

Or just comment lines 4-9.

7. Set up the database:

```rails db:create db:migrate db:seed```

8. Start the Rails server:

```rails s```

9. The Space Code Platform should now be accessible at [http://localhost:3000](http://localhost:3000)

10. Run all tests:

```rspec spec```

## API Documentation

The Space Code Platform API documentation is available at [API Documentation File](https://github.com/cboliveiras/space-code-platform/blob/main/API_Documentation.md). It provides detailed information about all the available endpoints, including request formats, parameters, and responses.

## Postman Collection

Test the endpoints on [Postman](https://cboliveiras.postman.co/workspace/New-Team-Workspace~1b824ad1-9e36-4ad8-a727-9110ae009b69/collection/18541010-9797c096-020e-4f88-a14f-0ead66466d22?action=share&creator=18541010)

You can also find the Postman documentation [here](https://documenter.getpostman.com/view/18541010/2s93z5AkVA)


### Have fun! I hope to see you soon :-)
