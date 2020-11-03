# README

rails api template with JWT

To start using this API in development mode:

1. Clone this repository to your local machine
2. Install postgress if necessary
3. Create postgress user if necessary
4. Run: rails db:create
5. Run: rails db:migrate
6. Run: rails db:seed
7. Run: Rails test. all test should pass

To start consuming the API:

You must be authorized to perform any action,
except POST api/v1/signup and POST api/v1/login.

To get JWT-token as json response,
signup or login with params: {email, password}

After signup or login include header:
"Authorization: Bearer <JWT-token>"

To see routes, schemas and aditional information for
this API, use file swagger.yml at the root of this
repository, and open it on https://editor.swagger.io/

Created by:
Norman Isaza https://github.com/isaza00/
Sebastian Escobar https://github.com/katorea132
Santiago Arboleda https://github.com/Blazeker
