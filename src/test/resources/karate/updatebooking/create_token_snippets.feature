@ignore
Feature: reusable

  Background:
    * url api.baseUrlGeneral

  @CreateToken
  Scenario: Creation of token
    * def requestToken =
      """
      {
          "username" : "admin",
          "password" : "password123"
      }
      """
    Given path 'auth'
    And request requestToken
    And header Content-Type = "application/json"
    When method Post
    Then status 200
