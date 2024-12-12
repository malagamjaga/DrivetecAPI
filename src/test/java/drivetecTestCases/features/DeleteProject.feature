@ProjDelete
Feature: Delete Project

Scenario: Delete Project post tests

    * def postResponse = karate.call('classpath:drivetecTestCases/features/UpdatePositions.feature')
    * def projId = postResponse.pjID
    * karate.log('Project ID fetched & updated in delete API:', projId)
    
    # Delete Project
    Given url apiUrl + '/Projects/' + projId + '/Delete'
    When method DELETE
    Then status 200
