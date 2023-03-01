Feature: As a user, I want to obtain the different reservations that have been made in the api.

  Background:
    * url api.baseUrlGeneral

  @GetBookingSuccessfully
  Scenario: Successful booking inquiry
    Given path 'booking/1'
    And header Accept = "application/json"
    When method Get
    Then status 200
    * def responseGet =
    """
      {
        "firstname": "#string",
        "lastname": "#string",
        "totalprice": "#number",
        "depositpaid": "#boolean",
        "bookingdates": {
            "checkin": "#string",
            "checkout": "#string"
        },
        "additionalneeds": "#string"
      }
    """
    And match response == responseGet

  @GetBookingWithoutHeader
  Scenario: Consult reservation without mandatory header : Alternate case
    Given path 'booking/111'
    When method Get
    Then status 418
    And match response == "I'm a Teapot"
