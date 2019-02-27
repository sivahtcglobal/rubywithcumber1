@nightly @hmhreport
Feature: HMH Reports.To verify the SRI Class Report

  Scenario Outline: F1: Verify that SRI Class Report is working
    Given Accessing the SRI Class Report using the <siteid> and <classid> in the <intelliview> with <key> and <secret>

    Then SRI Class Report should load as expected

    Then SRI Class report Summary Section should display as expected

    Then SRI Class report Row Chart Section should display as expected

    Then SRI Class report Row Chart Image Display as expected

    Then SRI Class report Table Group Header Section should display as expected

    Then SRI Class report Table Header Section should display as expected

    Then SRI Class report Table Values should display as expected for all the Students in the Class

    Then SRI Class report Verify the Date range Filter

    Then SRI Class report Verify the Reset icon

    When SRI Class report provide the Date range

    Then SRI Class report Verify the Class data with date range

    When SRI Class report Click on the reset icon

    Then SRI Class report Verify the Class data without date range

    Examples:
      |siteid    |classid                         |intelliview              |key                    |secret                             |
      |h900000031|1bu96flg6jj9ul1103967vhk_v8q9qq0|5617ef920cf2bffa80028a9c |yScTs-BpQVaSg0PIlDlfzw | 22ab106d-52c7-418f-a35a-1b1adb3c43bc          |