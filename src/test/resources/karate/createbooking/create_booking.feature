Feature: I as a user want to create different reservations in the api

  Background:
    * url api.baseUrl
    * def createHeaders = {'Content-Type': 'application/json', 'Accept': 'application/json'}

  @CreateBookingSuccessful
  Scenario Outline: Creation of a successful reserve: Successful case
    * def jsonRequestCreate = read("classpath:jsonbase/booking.json")
    And headers createHeaders
    And request jsonRequestCreate
    When method Post
    Then status 200
    And match response contains read("classpath:jsonbase/response_booking.json")

    Examples:
      | firstname | lastname | totalprice | depositpaid | checkin    | checkout   | additionalneeds |
      | Vanessa   | Arango   | 3000000    | true        | 2023-01-01 | 2024-01-07 | Almuerzo        |

  @CreateBookingAlternateCase
  Scenario Outline: Create a reserve that already exists: Alternate case
    * def createIdentity = call read("classpath:karate/createbooking/create_booking_snippets.feature@Create")
    * def jsonRequestCreate = read("classpath:jsonbase/booking.json")
    And headers createHeaders
    And request jsonRequestCreate
    When method Post
    Then status 200
    And match response contains read("classpath:jsonbase/response_booking.json")

    Examples:
      | firstname | lastname | totalprice | depositpaid | checkin    | checkout   | additionalneeds |
      | Vanessa   | Arango   | 3000000    | true        | 2023-01-01 | 2024-01-07 | Almuerzo        |

  @CreateBookingAlternate1
  Scenario Outline: Create a reservation without all headers : Alternate case 1
    * def jsonRequestCreate = read("classpath:jsonbase/booking.json")
    And request jsonRequestCreate
    When method Post
    Then status 418
    And match response == "I'm a Teapot"

    Examples:
      | firstname | lastname | totalprice | depositpaid | checkin    | checkout   | additionalneeds |
      | Vanessa   | Arango   | 3000000    | true        | 2023-01-01 | 2024-01-07 | Almuerzo        |

  @CreateBookingAlternate2
  Scenario Outline: Create a reservation without the Accept header : Alternate case 2
    * def jsonRequestCreate = read("classpath:jsonbase/booking.json")
    * remove createHeaders.<deletesHeader>
    And headers createHeaders
    And request jsonRequestCreate
    When method Post
    Then status 418
    And match response == "I'm a Teapot"

    Examples:
      | firstname | lastname | totalprice | depositpaid | checkin    | checkout   | additionalneeds | deletesHeader |
      | Vanessa   | Arango   | 3000000    | true        | 2023-01-01 | 2024-01-07 | Almuerzo        | Accept        |

  @CreateBookingAlternate3
  Scenario Outline: Creation of a reservation by removing some tags from the body : Alternate case3
    * def jsonRequestCreate = read("classpath:jsonbase/booking.json")
    * remove jsonRequestCreate.<deleteRequest>
    And headers createHeaders
    And request jsonRequestCreate
    When method Post
    Then status 500
    And match response == "Internal Server Error"

    Examples:
      | firstname | lastname | totalprice | depositpaid | checkin    | checkout   | additionalneeds | deleteRequest |
      | Vanessa   | Arango   | 3000000    | true        | 2023-01-01 | 2024-01-07 | Almuerzo        | firstname     |
      | Vanessa   | Arango   | 3000000    | true        | 2023-01-01 | 2024-01-07 | Almuerzo        | lastname      |
      | Vanessa   | Arango   | 3000000    | true        | 2023-01-01 | 2024-01-07 | Almuerzo        | totalprice    |
      | Vanessa   | Arango   | 3000000    | true        | 2023-01-01 | 2024-01-07 | Almuerzo        | depositpaid   |


  @CreateBookingAlternate4
  Scenario: Creation of a reservation without a body : Alternate case 4
    * remove jsonRequestCreate.<deleteRequest>
    When method Post
    Then status 500
    And match response == "Internal Server Error"

  @CreateBookingAlternate5
  Scenario Outline: Creating a reservation with dates in incorrect formats : Alternate case 5
    * def jsonRequestCreate = read("classpath:jsonbase/booking.json")
    And headers createHeaders
    And request jsonRequestCreate
    When method Post
    Then status 200
    And match response contains read("classpath:jsonbase/response_booking.json")

    Examples:
      | firstname | lastname | totalprice | depositpaid | checkin       | checkout    | additionalneeds |
      | Vanessa   | Arango   | 3000000    | true        | 2023-01-01    | 05-14-2024  | Almuerzo        |
      | Vanessa   | Arango   | 3000000    | true        | 2023-01-01    | 2024$-01-07 | Almuerzo        |
      | Vanessa   | Arango   | 3000000    | true        | 2023-01-01    | Fecha       | Almuerzo        |
      | Vanessa   | Arango   | 3000000    | true        | 05-01-2027    | 2024-01-07  | Almuerzo        |
      | Vanessa   | Arango   | 3000000    | true        | 2023-01>>$-01 | 2024-01-07  | Almuerzo        |
      | Vanessa   | Arango   | 3000000    | true        | Checkin       | 2024-01-07  | Almuerzo        |

  @CreateBookingAlternate6
  Scenario Outline: Creation of a reservation with empty fields : Alternate case 6
    * def jsonRequestCreate = read("classpath:jsonbase/booking.json")
    And headers createHeaders
    And request jsonRequestCreate
    When method Post
    Then status 500
    And match response == "Internal Server Error"

    Examples:
      | firstname | lastname | totalprice | depositpaid | checkin    | checkout   | additionalneeds |
      |           | Arango   | Reto       | Boolean     | 2023-01-01 | 2024-01-07 | Almuerzo        |
      | Vanessa   |          | Reto       | Boolean     | 2023-01-01 | 2024-01-07 | Almuerzo        |
      | Vanessa   | Arango   |            | Boolean     | 2023-01-01 | 2024-01-07 | Almuerzo        |
      | Vanessa   | Arango   | Reto       |             | 2023-01-01 | 2024-01-07 | Almuerzo        |
      | Vanessa   | Arango   | Reto       | Boolean     |            | 2024-01-07 | Almuerzo        |
      | Vanessa   | Arango   | Reto       | Boolean     | 2023-01-01 |            | Almuerzo        |
      |           |          |            |             |            |            |                 |