Feature: Test Search for Google

  Background: 
    Given Open Chrome Browser

  @SmokeTest
  Scenario: Search name in google
    Given Lunch Google in Browser
    When Search "Pritam"
    And Click on Search
    Then Verify Title "Pritam - Google Search"
    And Close the browser

  @RegressionTest
  Scenario Outline: Search name in google
    Given Lunch Google in Browser
    When Search "<SerachParameter>"
    And Click on Search
    Then Verify Title
    And Close the browser

    Examples: 
      | SerachParameter |
      | Soumendra       |
      | Sanjeev         |
