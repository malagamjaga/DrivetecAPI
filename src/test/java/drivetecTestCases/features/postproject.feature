    Feature: Create Project and Use ProjectId in Subsequent Requests
    @proj
    Scenario: Create Project and Use ProjectId

    # unique project name with "TPJ" prefix and a 5-digit number
    * def uniqueName = 'TPJ' + (java.lang.System.currentTimeMillis() % 100000)  

    # Request Payload for creating a Project with dynamic Name
    * def projectPayload = 
    """
    {
        "Id": "579816e4-6653-4794-b435-a885f32e28d7",
        "Name": "#(uniqueName)",
        "Address": "Hyderabad, Telangana, India",
        "Description": "",
        "CreatedBy": "579816e4-6653-4794-b435-a885f32e28d7",
        "ModifiedBy": "579816e4-6653-4794-b435-a885f32e28d7"
    }
    """
    
    Given url apiUrl + '/Projects'
    And request projectPayload
    When method post
    Then status 200
    And match response.Id != null
    * def prjId = response.Id

    # Store the captured ProjectId for later use
    * karate.set('projectId', prjId)

    # Log the generated unique project name
    * karate.log('Generated Project Name:', uniqueName)
