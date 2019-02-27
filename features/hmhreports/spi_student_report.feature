@nightly @hmhreport
Feature: HMH Reports.To verify the SPI Student Report

  Scenario Outline: F1: Verify that SPI Student Report is working
    Given Accessing the SPI Student Report for the <student> using the <siteid> and <classid> in the <intelliview> with <key> and <secret>

    Then SPI Student Report should load as expected

    Then SPI Student report Summary Section should display as expected

    Then SPI Student report line Chart Section should display as expected

    Then SPI Student report line Chart Image Display as expected

    Then SPI Student report Table Group Header Section should display as expected

    Then SPI Student report Table Header Section should display as expected

    Then SPI Student report Table Values should display as expected for all the Students in the Class

    Then SPI Student report Decoding Status Table Value should display

    Then SPI Student report Verify the Date range Filter

    Then SPI Student report Verify the Reset icon

    When SPI Student report provide the Date range

    Then SPI Student report Verify the Class data with date range

    When SPI Student report Click on the reset icon

    Then SPI Student report Verify the Class data without date range


  Examples:
  |student                         |siteid    |classid                         |intelliview              |key                    |secret                             |
  |oic7nalqmamjl8ghs7ctmsfu_v8q9qq0|h900000031|1bu96flg6jj9ul1103967vhk_v8q9qq0|561dc1ba0cf2bffa8004ff4a |yScTs-BpQVaSg0PIlDlfzw | 22ab106d-52c7-418f-a35a-1b1adb3c43bc          |