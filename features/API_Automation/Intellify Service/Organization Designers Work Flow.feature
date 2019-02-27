@commonAPI
Feature: Organization Designer Work Flow
  Scenario: Login to obtain Auth Token for End to End Work Flow Test
    * Login to obtain Auth Token for "Designer" to use in End to End Work Flow Test
  Scenario: Verify that the Org exist.
    * Verify that the Org exist.
  Scenario: Create New User with valid Password. Assert response code is 200
  * Create New User with valid Password. Assert response code is 200
  Scenario: Verify New User login
  * Verify New User login
  Scenario: Verify Created User Information. Assert response code is 204
  * Verify Created User Information. Assert response code is 204
  Scenario: Edit Password of New User by a different User
  * Edit Password of New User by a different User
  Scenario: Verify New User login with edidted Password
  * Verify New User login with edidted Password
  Scenario: Update Other fields of the User as a different User
  * Update Other fields of the User as a different User
  Scenario: Verify Updated User Information
  * Verify Updated User Information
  Scenario: Get Auth Tocken for the new User
  * Get Auth Tocken for the new User
  Scenario: Edit Password of New User with valid Password. Assert response code is 200
  * Edit Password of New User with valid Password. Assert response code is 200
  Scenario: Verify New User login. Assert response code is 200
  * Verify New User login. Assert response code is 200
  Scenario: Update Other fields of the User by a different User
  * Update Other fields of the User by a different User
  Scenario: Verify login with Updated Fields. Assert response code is 200
  * Verify login with Updated Fields. Assert response code is 200
  Scenario: Verify Updated User Information. Assert response code is 204
  * Verify Updated User Information. Assert response code is 204
  Scenario: Get Auth Token again with a Admin User.
  * Get Auth Token again with a Admin User.
  Scenario: Delete and Verify the User was successfully deleted
  * Delete and Verify the User was successfully deleted
  Scenario: Verify that the User was NOT created because of invalid password. Assert response code is 200
  * Verify that the User was NOT created because of invalid password. Assert response code is 200
  Scenario: Create a DataCollection using the Org as its parent
  * Create a DataCollection using the Org as its parent
  Scenario: Verify that the DataCollection was successfully created. Assert response code is 200
  * Verify that the DataCollection was successfully created. Assert response code is 200
  Scenario: Create a Data Source using the Data collection Created
  * Create a Data Source using the Data collection Created
  Scenario: Verify that the DataSource in the DataCollection was successfully created
  * Verify that the DataSource in the DataCollection was successfully created
  Scenario: Create a intellistream under the Data collection
  * Create a intellistream under the Data collection
  Scenario: Verify that the IntelliSream in the DataCollection was successfully created
  * Verify that the IntelliSream in the DataCollection was successfully created
  Scenario: Create new Dynamic Intellistream
  * Create new Dynamic Intellistream
  Scenario: Modify Dynamic Intellistream
  * Modify Dynamic Intellistream
  Scenario: Verify Dynamic Intellistream
  * Verify Dynamic Intellistream
  Scenario: Create a intelliview under the Data collection
  * Create a intelliview under the Data collection
  Scenario: Verify that the IntelliView in the DataCollection was successfully created
  * Verify that the IntelliView in the DataCollection was successfully created
  Scenario: Verify that the API key in the DataCollection was successfully created
  * Verify that the API key in the DataCollection was successfully created
  Scenario: Delete the IntelliStream. Assert response code is 204
  * Delete the IntelliStream. Assert response code is 204
  Scenario: Verify that IntelliStream was deleted. Assert response code is 404
  * Verify that IntelliStream was deleted. Assert response code is 404
  Scenario: Delete the Dynamic Stream
  * Delete the Dynamic Stream
  Scenario: Verify that Dynamic Stream was deleted
  * Verify that Dynamic Stream was deleted
  Scenario: Delete the IntelliView. Assert response code is 204
  * Delete the IntelliView. Assert response code is 204
  Scenario: Verify IntelliView was deleted. Assert response code is 404
  * Verify IntelliView was deleted. Assert response code is 404
  Scenario: Delete the DataSource. Assert response code is 204
  * Delete the DataSource. Assert response code is 204
  Scenario: Verify DataSource was deleted. Assert response code is 404
  * Verify DataSource was deleted. Assert response code is 404
  Scenario: Delete the API key. Assert response code is 204
  * Delete the API key. Assert response code is 204
  Scenario: Verify the API key was deleted. Assert response code is 404
  * Verify the API key was deleted. Assert response code is 404
  Scenario: Delete the DataCollection. Assert response code is 204
  * Delete the DataCollection. Assert response code is 204
  Scenario: Verify the DataCollection was deleted. Assert response code is 404
  * Verify the DataCollection was deleted. Assert response code is 404
