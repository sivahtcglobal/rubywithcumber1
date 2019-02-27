
Feature: HMH Reports.To verify the R180 Class Report

  Scenario Outline: F1: Verify that R180 Class Report is working
    Given Accessing the R180U Class Report using the <siteid> and <classid> in the <intelliview> with <key> and <secret>

    Then R180U Class report header should display as expected

    Then R180U Class report Summary Section should display as expected

    Then R180U Class report Line Chart Section should display as expected

    Then R180U Class report Line Chart Image Display as expected

    Then R180U Class report Table Group Header Section should display as expected

    Then R180U Class report Table Header Section should display as expected

    Then R180U Class report Table Values should display as expected for all the Students in the Class

    Then R180U Class report Verify the Date range Filter

    Then R180u Class report Verify the Reset icon

    When R180U Class report provide the Date range

    Then R180U Class report Verify the Class data with date range

    When R180U Class report Click on the reset icon

    Then R180U Class report Verify the Class data without date range





    Examples:
      |siteid    |classid                         |intelliview              |key                    |secret                                |
      |h900000031|pjg5omnv7r2hbk29le0p24b6_v8q9qq0|561dc0fb0cf2bffa8004feff |yScTs-BpQVaSg0PIlDlfzw | 22ab106d-52c7-418f-a35a-1b1adb3c43bc |

