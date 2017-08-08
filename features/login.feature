Feature: Login
As a user I should be able to login to the website


   Scenario: B2CLogn
    When I login as admin
    #Then I should be loggedin

  @smoke
   Scenario: Register user successfully
     Given I navigate to Audi homepage
     When I click on yourAudi link on homepage
     Then I navigate to yourAudi login homepage
     And I click on register link on yourAudi login page
     When I enter all user details successfully
     Then user success message is displayed

  @smoke
   Scenario: user login successfully
     Given I navigate to Audi homepage
     When I click on yourAudi link on homepage
     Then I navigate to yourAudi login homepage




