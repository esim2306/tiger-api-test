Feature: Create Account

Background: generate token for all scenarios
Given url "https://tek-insurance-api.azurewebsites.net"
And path "/api/token"
And request {"username": "supervisor", "password": "tek_supervisor"}
When method post
Then status 200
* def generatedToken = response.token

Scenario: Create new account happy path
Given path "/api/accounts/add-primary-account"
And request {"email":"esim1@gmail.com","firstName":"Deke","lastName":"Beisen","title":"Mr.","gender":"MALE","maritalStatus":"SINGLE","employmentStatus":"student","dateOfBirth":"2000-03-03"}
And header Authorization = "Bearer " + generatedToken
When method post
And print response
Then status 201

Scenario: Create new account with Existing email address
Given path "/api/accounts/add-primary-account"
And request {"email": "esim2306@gmail.com", "firstName": "Dima", "lastName": "Babko", "title": "Mr.", "gender": "MALE", "maritalStatus": "SINGLE", "employmentStatus": "developer", "dateOfBirth": "1991-03-01"}
And header Authorization = "Bearer " + generatedToken
When method post
Then status 400
And print response
* def errorMessage = response.errorMessage
	And assert errorMessage == "Account with Email esim2306@gmail.com is exist"