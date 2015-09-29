Feature: Searching

  Scenario Outline: Check searching
    Given I open <resultsPage>:
    And I choose random search term from advanced search
    When I make searching with advanced search and simple search tools
    Then Results should be equals

  Examples:
  | resultsPage                             |
  | http://backmy.bike/bikes                |
  | http://backmy.bike/bikes?status_=stolen |
  | http://backmy.bike/bikes?status_=found  |
