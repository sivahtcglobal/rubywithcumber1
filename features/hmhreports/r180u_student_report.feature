
Feature: HMH Reports.To verify the R180 Student Report

  Scenario Outline: F1: Verify that R180 Student Report is working
    Given Accessing the R180U Student Report for the <student> using the <siteid> and <classid> in the <intelliview> with <key> and <secret>

    Then The R180U Student Report should load as expected

    Then R180U Student report header should display as expected

    Then R180U Student report Summary Section should display as expected

    Then R180U Student report Bar Chart Section should display as expected

    Then R180U Student report Bar Chart Image Display as expected

    Then R180U Student report Table Group Header Section should display as expected

    Then R180U Student report Table Header Section should display as expected

    Then R180U Student report Table Values should display as expected for the Students

    Then R180U Student report Verify the Date range Filter

    Then R180u Student report Verify the Reset icon

    When R180U Student report provide the Date range

    Then R180U Student report Verify the student data with date range

    When R180U Student report Click on the reset icon

    Then R180U Student report Verify the student data without date range

  Examples:
  |student                         |siteid    |classid                         |intelliview              |key                    |secret                             |
  |337oro96ar88asu7hpoedqf5_v8q9qq0|h900000031|pjg5omnv7r2hbk29le0p24b6_v8q9qq0|561dc1310cf29cf10bd93079 |yScTs-BpQVaSg0PIlDlfzw | 22ab106d-52c7-418f-a35a-1b1adb3c43bc          |