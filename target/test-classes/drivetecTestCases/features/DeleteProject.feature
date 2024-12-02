Feature: Delete Project
@ProjDelete
Scenario: Delete Project post tests

    * def postResponse = karate.call('classpath:drivetecTestCases/features/CreateProject.feature')
    * def projId = postResponse.projectId
    
    # Delete Project
    Given url apiUrl + '/Projects/' + projId + '/Delete'
    When method DELETE
    Then status 200
