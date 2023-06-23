# API Documentation


Headers
  - Accept: application/json
  - Content-Type: application/json

```json
### GET /v1/pilots

- Response (200 OK)
[
  {
  "id": 1,
  "name": "John Doe",
  "age": 30,
  "certification": "ABC123",
  "credits": 1000,
  "location": "Andvari"
  }
]

### GET /v1/pilots/:id

- Response (200 OK):
{
  "id": 1,
  "name": "John Doe",
  "age": 30,
  "certification": "ABC123",
  "credits": 1000,
  "location": "Andvari"
}

- Response (404 Not Found):

{  "error": "Pilot not found" }

### POST /v1/pilots

- Payload:

{
  "name": "John Doe",
  "age": 30,
  "certification": "ABC123",
  "credits": 1000,
  "location": "Andvari"
}

- Response (201 Created):

{
  "id": 1,
  "name": "John Doe",
  "age": 30,
  "certification": "ABC123",
  "credits": 1000,
  "location": "Andvari"
}

- Response (422 Unprocessable Entity)

{ "error": "Invalid data" }

### GET /v1/pilots/:pilot_id/ships

- Response (200 OK):

{
  "id": 10,
  "fuel_capacity": 195.0,
  "fuel_level": 72.0,
  "weight_capacity": 1087.0,
  "pilot_id": 2,
}

### POST /v1/pilots/:pilot_id/ships

- Payload:

{
  "fuel_capacity": 150,
  "fuel_level": 100,
  "weight_capacity": 2000,
  "pilot_id": 9,
}

- Response (201 Created)

{
  "id": 12,
  "fuel_capacity": 200.0,
  "fuel_level": 100.0,
  "weight_capacity": 1500.0,
  "pilot_id": 1,
}

- Response (400 Bad Request)

{ "error": "Invalid data" }

### POST /v1/pilots/:id/grant_credits

- Payload

{
  "contract_id: 2,
  "travel_id": 1,
}

- Response (200 OK):

{  "message": "Yes, you did it! Credits granted!" }

- Response (422 Unprocessable Entity):

{  "error": "Invalid contract fulfillment." }

### POST /v1/pilots/:id/travel_between_planets

- Payload:

{
  "to_planet": "Demeter",
}

- Response (200 OK):

{  "message": "Travel successful!" }

- Response (422 Unprocessable Entity):

{  "error": "Insufficient fuel for the journey. Please refuel" }

### POST /v1/pilots/:id/register_fuel_refill

Payload:

{
  "to_planet": "Andvari",
}

- Response (200 OK):

{  "message": "Fuel refill successful!" }

- Response (422 Unprocessable Entity):

{  "error": "Cannot refill. Check the credits or the fuel ship capacity" }

### GET /v1/contracts

- Response (200 OK):
[
  {
    "id": 1,
    "description": "Water to Demeter",
    "from_planet": "Andvari",
    "to_planet": "Demeter",
    "value": 2817.0,
    "status": "open",
    "ship_id": null,
    },
  {
     "id": 2,
     "description": "Food to Aqua",
     "from_planet": "Andvari",
     "to_planet": "Aqua",
     "value": 1603.0,
     "status": "open",
     "ship_id": null,
    },
]

### GET /v1/contracts/:id

- Response (200 OK):

{
  "id": 1,
  "description": "Water to Demeter",
  "from_planet": "Andvari",
  "to_planet": "Demeter",
  "value": 2000,
  "status": "OPEN",
}

- Response (404 Not Found)

{ "error": "Contract not found" }

### POST /v1/contracts

- Payload:

{
  "description": "Water to Demeter",
  "from_planet": "Andvari",
  "to_planet": "Demeter",
  "value": 2000,
}

- Response (201 Created):

{
  "id": 1,
  "description": "Water to Demeter",
  "from_planet": "Andvari",
  "to_planet": "Demeter",
  "value": 2000,
  "status": "OPEN",
}

- Response (422 Unprocessable Entity):

{  "error": "Invalid contract data" }

### PATCH /v1/contracts/:id

Payload:

{  "status": "FINISHED" }

- Response (200 OK):

{
  "id": 1,
  "description": "Water to Demeter",
  "from_planet": "Andvari",
  "to_planet": "Demeter",
  "value": 2000,
  "status": "FINISHED"
}

- Response (422 Unprocessable Entity):

{  "error": "Invalid entry" }

### GET /v1/contracts/list_open_contracts

- Response (200 OK):

[
  {
    "id": 1,
    "description": "Water to Demeter",
    "from_planet": "Andvari",
    "to_planet": "Demeter",
    "value": 2000,
    "status": "OPEN"
  },
  {
    "id": 2,
    "description": "Food to Aqua",
    "from_planet": "Andvari",
    "to_planet": "Aqua",
    "value": 1500,
    "status": "OPEN"
  }
]

### POST /v1/contracts/:id/accept_contract

- Response (200 OK):

{
  "id": 1,
  "description": "Water to Demeter",
  "from_planet": "Andvari",
  "to_planet": "Demeter",
  "value": 2000,
  "status": "TAKEN"
}

- Response (422 Unprocessable Entity):

{  "error": "Contract is not in the 'OPEN' status" }

### GET /v1/reports/resource_weights

- Response (200 OK):

{
  "Andvari": {
    "sent": {
      "water": 1000,
      "food": 500
    },
    "received": {
      "minerals": 200
    }
  },
  "Demeter": {
    "sent": {
      "water": 500,
      "minerals": 300
    },
    "received": {
      "food": 800
    }
  }
}

### GET /v1/reports/resource_percentage

- Response (200 OK):

{
  "John Doe": {
    "water": 60,
    "food": 30,
    "minerals": 10
  },
  "Jane Smith": {
    "water": 40,
    "minerals": 60
  }
}

### GET /v1/reports/ledger_transactions

- Response (200 OK):

[
  "Water to Demeter paid: ₭2000.00",
  "Food to Aqua paid: ₭1500.00",
  "Minerals to Calas paid: ₭1000.00"
]

