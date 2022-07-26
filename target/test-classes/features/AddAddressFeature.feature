Feature: Create an account and add address to the account

Background: Create new account.
Given url "https://tek-insurance-api.azurewebsites.net"
* def createAccountResult = callonce read('CreateAccountFeature.feature')
And print createAccountResult
* def primaryPersonId = createAccountResult.response.id
* def token = createAccountResult.result.response.token

Scenario: Add address to an account
Given path '/api/accounts/add-account-address'
And param primaryPersonId = primaryPersonId
Given header Autorization = "Bearer " + token
Given request 
"""
{
  "addressType": "Home",
  "addressLine1": "9061 Cincinnati Columbus Road",
  "city": "West Chester",
  "state": "Ohio",
  "postalCode": "45069",
  "countryCode": "1",
  "current": true
}
"""
When method post
Then status 201
And print post