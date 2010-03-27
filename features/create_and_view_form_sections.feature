Feature: As an admin I should be able to create and view form sections
 @wip
  Scenario:      To view a list of existing forms as an admin

    Given "admin" is logged in
    When I view the list of form sections
    Then I should see the "Basic Details" form section
    And I should see the "Family Details" form section







