@commonAPI @ignoreInK12
Feature: Computed Intellistream executionType must be ONGOING or BOUNDED Validation

  Scenario: Create Computed Intellistream with executionType as 'ONGOING'
* Create Computed Intellistream with executionType as 'ONGOING'
  Scenario: Create Computed Intellistream with executionType as 'BOUNDED'
* Create Computed Intellistream with executionType as 'BOUNDED'
  Scenario: Create Computed Intellistream with Invalid executionType - expect fail
* Create Computed Intellistream with Invalid executionType - expect fail
  Scenario: Delete Computed Intellistream for executionType as 'BOUNDED'
* Delete Computed Intellistream for executionType as 'BOUNDED'
  Scenario: Verify that IntelliStream for executionType as 'BOUNDED' was deleted. Assert response code is 404
* Verify that IntelliStream for executionType as 'BOUNDED' was deleted. Assert response code is 404
  Scenario: Delete Computed Intellistream for executionType as 'ONGOING'
* Delete Computed Intellistream for executionType as 'ONGOING'
  Scenario: Verify that IntelliStream for executionType as 'ONGOING' was deleted. Assert response code is 404
* Verify that IntelliStream for executionType as 'ONGOING' was deleted. Assert response code is 404

