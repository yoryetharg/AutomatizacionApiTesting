@ignore
Feature: reusable

  Background:
    * url api.baseUrl

  @Create
  Scenario: Create booking
    * def jsonRequestCreate = read("classpath:jsonbase/booking.json")
    And headers createHeaders
    And request jsonRequestCreate
    When method Post
    Then status 200