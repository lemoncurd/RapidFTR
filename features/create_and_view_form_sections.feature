Feature: As an admin I should be able to create and view form sections
  #@wip
  Scenario:      To view a list of existing forms as an admin

    Given "admin" is logged in
    When I am on form section page
    Then I should see "Basic Details" within ".formSectionLink"
    Then I should see "Family Details" within ".formSectionLink"







