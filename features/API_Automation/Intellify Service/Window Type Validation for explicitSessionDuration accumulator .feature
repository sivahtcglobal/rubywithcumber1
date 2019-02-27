@commonAPI @ignoreInK12
Feature: Window Type Validation for explicitSessionDuration accumulator

  Scenario: Login and obtain authToken for explicitSessionDuration accumulator
  * Login and obtain authToken for explicitSessionDuration accumulator
  Scenario: Validate with Invalid Window type GroupRollingSpec
    * Validate with Invalid Window type GroupRollingSpec
  Scenario: Validate with Invalid Window type GroupTimeWindowSpec
    * Validate with Invalid Window type GroupTimeWindowSpec
  Scenario: Validate with  Window type GroupExplicitSessionWindowSpec
    * Validate with  Window type GroupExplicitSessionWindowSpec
  Scenario: Validate with Valid Window type GroupSessionWindowSpec
    * Validate with Valid Window type GroupSessionWindowSpec
  Scenario: Delete the Compute stream created using the Valid Window Type
    * Delete the Compute stream created using the Valid Window Type
  Scenario: Delete the Compute stream  Window Tyop GroupExplicitSessionWindowSpec
    * Delete the Compute stream  Window Type GroupExplicitSessionWindowSpec
  Scenario: Verify compute stream created with GroupExplicitSessionWindowSpec deleted successfully
    * Verify compute stream created with GroupExplicitSessionWindowSpec deleted successfully
  Scenario: Verify compute stream created with GroupSessionWindowSpec deleted successfully
    * Verify compute stream created with GroupSessionWindowSpec deleted successfully
