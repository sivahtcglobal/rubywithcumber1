@essentials
Feature: Intellify Essential datatools page element verification-Non Adminuser
  Scenario:Data tools page element verification-Non Adminuser
      Given Data Tools-login to with Valid credentials-Non Adminuser
      Then Verify the tools added Tableau and CSV-Non Adminuser
      Then Verify the elements in Tableau and CSV Tools-Non Adminuser
