@postconfig
Feature: Test Configurations API

# This is the before hook where we define the setup logic
Background:
  # This runs before each scenario and generates the ProjectId once
 
  * def projectId = karate.callSingle('classpath:drivetecTestCases/features/CreateProject.feature')
  * karate.log('Using ProjectId: ', projectId)

Scenario: Generate Config ID

  # Generate a unique name with "Dataset" prefix and a 4-digit number (0001, 0002, ...)
  * def counter = (java.lang.System.currentTimeMillis() % 10000) + 1  //Generate a number between 1 and 10000
  * def formattedCounter = (counter.toString().length() < 4) ? ('0000' + counter).substring(counter.toString().length()) : counter.toString()  
  * def positionName = 'Dataset' + formattedCounter  // Combine the prefix with the formatted counter
  
  # # Call the project feature to set projectId
  # * callonce read('postproject.feature')

  # # Retrieve the projectId
  # * def projectId = karate.get('projectId')

  # Request Payload for creating a Configuration with dynamic Name and ProjectId
  * def dynamicPayload = 
  """
  {
      "Id": "00000000-0000-0000-0000-000000000000",
      "ProjectId": "#(projectId.prjId)",
      "Name": "#(positionName)",
      "Description": "#(positionName)",
      "CustomTags": "",
      "CreatedBy": "579816e4-6653-4794-b435-a885f32e28d7",
      "ModifiedBy": "579816e4-6653-4794-b435-a885f32e28d7",
      "ApplicationName": 1,
      "System": "",
      "FacadeInclination": 0,
      "OpeningType": 1,
      "OpeningDirection": 1,
      "OpeningWidth": 1000,
      "VentOuterWidth": 1230,
      "VentOuterHeight": 1480,
      "VentWeight": 70,
      "CalculateWeightWithGlass": false,
      "WeightIncGlassOrThickness": false,
      "GlassThickness": 14,
      "ProfileWeightPerSerialMeter": 2.5,
      "IsWindowOpeningCalculationByAngle": 1,
      "RequiredOpeningStroke": 400,
      "OpeningAngle": 15,
      "WindLoad": 120,
      "SnowLoad": 0,
      "DrivePosition": 2,
      "InstallationPosition": 1,
      "ChainLengthConnectingRodHandle": 5,
      "LockingMechanism": 1,
      "Voltage": 1,
      "DriveType": 1,
      "TypeOfInstallation": 2,
      "CalculationTypeForVentilation": 1,
      "CalcVentilation": 1,
      "GeometricArea": 1,
      "SpecificExhaustDimension": 30,
      "BuildingDepth": 75,
      "RevealDepth": 0,
      "RevealDepthRectangleAngle1": 0,
      "RevealDepthRectangleAngle2": 0,
      "HeightOfProfile": 0,
      "HeightProfileRectangleAngle1": 0,
      "HeightProfileRectangleAngle2": 0,
      "AkippOrAtilt": 0,
      "AdrehOrAturn": 0,
      "Ageo": 0,
      "MinPullingForceMax": 0,
      "MinPushingForceMax": 0,
      "MinPullingForcePermanent": 0,
      "MinPushingForcePermanent": 0,
      "ForceWithNegativeWind": 0
  }
  """

  Given url apiUrl + '/Configurations'
  And request dynamicPayload
  When method post
  Then status 200
  And match response.Id != null
  
  * def configId = response.Id
  * def projId = response.ProjectId
  * karate.log('Generated Config ID:', configId)
  * karate.log('Generated Name:', dynamicPayload.Name)
  * karate.log('Generated Description:', dynamicPayload.Description)
  * karate.set('generatedData', { configId: configId, name: dynamicPayload.Name, description: dynamicPayload.Description })
