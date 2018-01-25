@essentials @canvas @smoketest
Feature: Essential UI home page element validation
  Scenario: Verify the element in home page for Intellify Essential
      Given login to intellify essential page username and password
      And Verify all element in the home page
      Then click on the data source tab
      And Verify all element in data source tab
     Then click on the data tools tab
      And verify all element in the data tools
     Then click on the Account Settings  tab
      And verify all element in the Account Settings tab
     Then click on the Help tab
      And verify all element in the help tab
     Then click Refresh button on data source tab
      And Verify the data source tab reload and stay on same page
    Then Click on the Logout icon
      And Verify the Login Page