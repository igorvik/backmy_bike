Feature: Output results

  Scenario Outline: Check output results
    Given I navigate to <resultsPage>:
    When I write down quantity of picture from the first and last pages
    Then Results should be in a range from 1 to 8 pictures on each page

    Examples:
      | resultsPage                             |
      | http://backmy.bike/bikes                |
      | http://backmy.bike/bikes?status_=stolen |
      | http://backmy.bike/bikes?status_=found  |


