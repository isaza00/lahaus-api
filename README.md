# README

rails api template with JWT

you must be authorized to perform any action,
except POST api/v1/users/ and POST api/v1/login

include header:
"Authorization: Bearer <JWT-token>"

to get JWT-token as json response,
create new user or login, params: {email, password}

Actions
# show all users
GET api/v1/users
# show user with id = <id>
GET api/v1/users/<id>
# show user with id = <id>
PUT api/v1/users/<id>
# show user with id = <id>
DELETE api/v1/users/<id>
# create user
POST api/v1/users/
