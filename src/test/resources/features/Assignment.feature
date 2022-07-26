Feature: New account Feature
Background:
Given url "https://tek-insurance-api.azurewebsites.net"
	And path "/api/token"
	And request {"username": "supervisor", "password": "tek_supervisor"}
	When method post
	Then status 200
	* def generatedToken = response.token
	
#Scenario: Create new account happy path
#Given path "/api/accounts/add-primary-account"
#And request {"email":"esim1@gmail.com","firstName":"Deke","lastName":"Beisen","title":"Mr.","gender":"MALE","maritalStatus":"SINGLE","employmentStatus":"student","dateOfBirth":"2000-03-03"}
#And header Authorization = "Bearer " + generatedToken
#When method post
#Then status 201
#* def generatedId = response.id
#And print generatedId
#And print response	

Scenario: Create new account with Existing email address
Given path "/api/accounts/add-primary-account"
And request {"email": "esim19@gmail.com", "firstName": "Deke", "lastName": "Beisen", "title": "Mr.", "gender": "MALE", "maritalStatus": "SINGLE", "employmentStatus": "student", "dateOfBirth": "2000-03-03"}
And header Authorization = "Bearer " + generatedToken
When method post
Then status 400
And print response
* def errorMessage = response.errorMessage
	And assert errorMessage == "Account with Email esim19@gmail.com is exist"
	
Scenario: Add car to existing Account
Given path "/api/accounts/add-account-car"
And param primaryPersonId = 189
And request {"make": "Toyota","model": "Camry","year": "2005","licensePlate": "8XC4501"}
And header Authorization = "Bearer " + generatedToken
When method post
Then status 201
And print response

Scenario: Add phone number to existing account
Given path "/api/accounts/add-account-phone"
And param primaryPersonId = 189
And request {"phoneNumber": "6463770011","phoneExtension": "+1","phoneTime": "Evening","phoneType": "Mobile", "current": "true"}
And header Authorization = "Bearer " + generatedToken
When method post
Then status 201
And print response

Scenario: Add address to existing Account
Given path "/api/accounts/add-account-address"
And param primaryPersonId = 189
And request {"addressType": "Home", "addressLine1": "601 Tylersville Rd","city": "Cincinnati","state": "Ohio","postalCode": "45040","countryCode": "1","current": "true"}
And header Authorization = "Bearer " + generatedToken
When method post
Then status 201
And print response










