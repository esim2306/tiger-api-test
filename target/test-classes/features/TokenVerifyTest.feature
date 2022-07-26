	Feature: Security test. Verify Token Test
	
		Scenario: generate a valid token with verify it with below requirement.
	Given url "https://tek-insurance-api.azurewebsites.net"
	And path "/api/token"
	And request {"username": "supervisor", "password": "tek_supervisor"}
	When method post
	Then status 200
	* def generatedToken = response.token
	Given path "/api/token/verify"
	And param username = "supervisor"
	And param token = generatedToken
	When method get
	Then status 200
	And print response
	
	Scenario: Verify invalid token
	Given url "https://tek-insurance-api.azurewebsites.net"
	Given path "/api/token/verify"
	And param username = "supervisor"
	And param token = 012121
	When method get
	Then status 400
	And print response

	
	Scenario: test token verify with valid token and invalid username
	Given url "https://tek-insurance-api.azurewebsites.net"
	And path "/api/token"
	And request {"username": "supervisor", "password": "tek_supervisor"}
	When method post
	Then status 200
	* def generatedToken = response.token
	Given path "/api/token/verify"
	And param username = "supervisor1"
	And param token = generatedToken
	When method get
	Then status 400
	And print response
	* def errorMessage = response.errorMessage
	And assert errorMessage == "Wrong Username send along with Token"