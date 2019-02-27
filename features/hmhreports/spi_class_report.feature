@nightly @hmhreport
Feature: HMH Reports.To verify the SPI Class Report

  Scenario Outline: F1: Verify that SPI Class Report is working
    Given Accessing the SPI Class Report using the <siteid> and <classid> in the <intelliview> with <key> and <secret>

    Then The SPI Class Report should load as expected

    Then SPI Class report Summary Section should display as expected

    Then SPI Class report Row Chart Section should display as expected

    Then SPI Class report Row Chart Image Display as expected

    Then SPI Class report Table Group Header Section should display as expected

    Then SPI Class report Table Header Section should display as expected

    Then SPI Class report Table Values should display as expected for all the Students in the Class

    Then SPI Class report Decoding Status Table Value should display

    Then SPI Class report Verify the Date range Filter

    Then SPI Class report Verify the Reset icon

    When SPI Class report provide the Date range

    Then SPI Class report Verify the Class data with date range

    When SPI Class report Click on the reset icon

    Then SPI Class report Verify the Class data without date range

    Examples:
      |siteid    |classid                         |intelliview              |key                    |secret                             |
      |h900000031|1bu96flg6jj9ul1103967vhk_v8q9qq0|55f9c01a0cf2011135f8754f |yScTs-BpQVaSg0PIlDlfzw | 22ab106d-52c7-418f-a35a-1b1adb3c43bc          |