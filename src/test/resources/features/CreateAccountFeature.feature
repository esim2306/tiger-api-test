Feature: Create an Account with Data generator
#We are going to re-use a generate token feature

Background: Prepare for test.generate token
Given url "https://tek-insurance-api.azurewebsites.net"
* def result = callonce read('GenerateToken.feature')
* def generatedToken = result.response.token
And header Authorization = "Bearer " + generatedToken

Scenario: Create New account using Data generator;
* def generator = Java.type('tiger.api.test.fake.DataGenerator')
* def email = generator.getEmail()
* def firstName = generator.getFirstName()
* def lastName = generator.getLastName()
* def dob = generator.getDob()
Given path "/api/accounts/add-primary-account"
And request
	"""
	{"email": "#(email)",
  "firstName": "#(firstName)",
  "lastName": "#(lastName)",
  "title": "Mr.",
  "gender": "MALE",
  "maritalStatus": "MARRIED",
  "employmentStatus": "student",
  "dateOfBirth": "#(dob)",
  }
  """
 	When method post
	Then status 201
	* def generatedId = response.id
	And print generatedId
	And print response
	Then assert response.email == email