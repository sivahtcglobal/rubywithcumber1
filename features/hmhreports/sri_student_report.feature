@nightly @hmhreport
Feature: HMH Reports.To verify the SRI Student Report

  Scenario Outline: F1: Verify that SRI Student Report is working
    Given Accessing the SRI Student Report for the <student> using the <siteid> and <classid> in the <intelliview> with <key> and <secret>

    Then SRI Student Report  should load as expected

    Then SRI Student report Summary Section should display as expected

    Then SRI Student report line Chart Section should display as expected

    Then SRI Student report line Chart Image Display as expected

    Then SRI Student report Table Group Header Section should display as expected

    Then SRI Student report Table Header Section should display as expected

    Then SRI Student report Table Values should display as expected for all the Students in the Class

    Then SRI Student report Verify the Date range Filter

    Then SRI Student report Verify the Reset icon

    When SRI Student report provide the Date range

    Then SRI Student report Verify the Class data with date range

    When SRI Student report Click on the reset icon

    Then SRI Student report Verify the Class data without date range

    Examples:
      |student                         |siteid    |classid                         |intelliview              |key                    |secret                             |
      |oic7nalqmamjl8ghs7ctmsfu_v8q9qq0|h900000031|1bu96flg6jj9ul1103967vhk_v8q9qq0|5661b62d0cf2c1c8405734a5 |yScTs-BpQVaSg0PIlDlfzw | 22ab106d-52c7-418f-a35a-1b1adb3c43bc          |