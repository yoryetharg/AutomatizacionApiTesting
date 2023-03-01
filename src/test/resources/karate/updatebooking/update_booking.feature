Feature: I as a user would like to update the Api reserves.

  Background:
    * url api.baseUrlGeneral
    * def generateNumber = karate.read("classpath:karate/generate-random.js")
    * def lastname = generateNumber(7)

  @UpdateSuccessful
  Scenario Outline: Update reservation by obtaining token value from endpoint create Token
    * def lastname = generateNumber(10)
    * def jsonRequestUpdate = read("classpath:jsonbase/booking.json")
    * def createTokenAuth = call read("create_token_snippets.feature@CreateToken")
    * def tokenValue = createTokenAuth.response.token
    * def updateHeaders = {'Content-Type': 'application/json', 'Accept': 'application/json', 'Cookie': '#("<token>" + tokenValue)', 'Authorizationopcional': 'Basic YWRtaW46cGFzc3dvcmQxMjM='}
    Given path 'booking/1'
    And headers updateHeaders
    * print updateHeaders
    And request jsonRequestUpdate
    When method Put
    Then status 200
    * def responseUpdate =
    """
    {
        "firstname" : "#string",
        "lastname" : "#string",
        "totalprice" : "#number",
        "depositpaid" : "#boolean",
        "bookingdates" : {
            "checkin" : "#string",
            "checkout" : "#string"
        },
        "additionalneeds" : "#string"
    }
    """
    And match response == responseUpdate

    Examples:
      | token  | firstname | totalprice | depositpaid | checkin    | checkout   | additionalneeds |
      | token= | Vanessa   | 3000000    | true        | 2023-01-01 | 2024-01-07 | Almuerzo        |

  @UpdateAlternate
  Scenario Outline: Updating reservation without sending headers
    * def lastname = generateNumber(7)
    * def jsonRequestUpdate = read("classpath:jsonbase/booking.json")
    Given path 'booking/1'
    And request jsonRequestUpdate
    When method Put
    Then status 403
    And match response == "Forbidden"

    Examples:
      | token  | firstname | totalprice | depositpaid | checkin    | checkout   | additionalneeds |
      | token= | Vanessa   | 3000000    | true        | 2023-01-01 | 2024-01-07 | Almuerzo        |