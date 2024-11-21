Feature: Printing all "Name" keys from the response
@recommdrive
Scenario: Iterate over the response to print all "Name" keys
    Given url apiUrl + '/Config/0413f204-c057-427c-9439-44091f1470d0/Drive'
    And header Content-Type = 'application/json'
    And method GET
    Then status 200
    And def response = response
    * karate.forEach(response, function(item) { karate.log('Name: ' + item.Name)})
