# Versos Perfectos

Source code of spanish hip-hop website [VersosPerfectos.com](http://versosperfectos.com)

## Database setup

Instead of running the typical `rake db:migrate` you must use `rake db:schema:load` to create the database since the migrations we generated for this project were created to transform in order to follow the proper rails conventions. As we are not supplying our original database you should do a schema load instead of running migrations.

## Environment variables

There are a bunch of environment variables needed to make the project work.

TBC