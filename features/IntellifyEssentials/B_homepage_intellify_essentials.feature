@essentials
Feature: Intellify Essential home page
  Scenario: Verify the element in home page for Intellify Essential
      Given login to intellify essential page username and password
      Then Verify all element in the home page
      When click on the data source tab
      Then Verify all element in data source tab
#      When click on the data store tab
#      Then verify all element in data store tab
     When click on the data tools tab
      Then verify all element in the data tools
     When click on the Account Settings  tab
      Then verify all element in the Account Settings tab
     When click on the Help tab
      Then verify all element in the help tab
     When click Refresh button on data source tab
      Then Verify the data source tab reload and stay on same page
    When Click on the Logout icon
      Then Verify the Login Page