@commonAPI
Feature: Refresh Token

  Scenario: Refresh token to set expiry in 5 minutes. Assert response code is 200
* Refresh token to set expiry in 5 minutes. Assert response code is 200
  Scenario: Verify that refresh token works. Assert response code is 200
* Verify that refresh token works. Assert response code is 200
  Scenario: Refresh token to set expiry in 1second. Assert response code is 200
* Refresh token to set expiry in 1second. Assert response code is 200
  Scenario: Verify that refresh token has expired. Assert response code is 401
* Verify that refresh token has expired. Assert response code is 401
  Scenario: Refresh token to set expiry in 10minute. Assert response code is 200
* Refresh token to set expiry in 10minute. Assert response code is 200
  Scenario: Again Verify that refresh token works. Assert response code is 200
* Again Verify that refresh token works. Assert response code is 200
  Scenario: Verify with bogus token. Assert response code is 400
* Verify with bogus token. Assert response code is 400

