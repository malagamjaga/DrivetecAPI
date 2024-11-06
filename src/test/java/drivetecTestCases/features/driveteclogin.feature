Feature: DriveTec Configurations

@drivetec
Scenario Outline: Drivetec Configurations test
 
  * def datasetName = '<DatasetName>'
  * karate.log('Running test for dataset: ', datasetName)

  Given url apiUrl + '/Configurations'
  And header Content-Type = 'application/json'
  And request 
  """
      {
      "Id": "<Id>",
      "Name": "<Name>",
      "Description": "",
      "ProjectId": "<ProjectId>",
      "CustomTags": "",
      "CreatedBy": "<CreatedBy>",
      "ModifiedBy": "<ModifiedBy>",
      "System": "",
      "FacadeInclination": <FacadeInclination>,
      "OpeningType": <OpeningType>,
      "OpeningDirection": <OpeningDirection>,
      "OpeningWidth": <OpeningWidth>,
      "VentOuterWidth": <VentOuterWidth>,
      "VentOuterHeight": <VentOuterHeight>,
      "VentWeight": <VentWeight>,
      "CalculateWeightWithGlass": #(!CalculateWeightWithGlass),
      "RequiredOpeningStroke": <RequiredOpeningStroke>,
      "WindLoad": <WindLoad>,
      "SnowLoad": <SnowLoad>,
      "IsWindowOpeningCalculationByAngle": <IsWindowOpeningCalculationByAngle>,
      "GlassThickness": <GlassThickness>,
      "ProfileWeightPerSerialMeter": <ProfileWeightPerSerialMeter>,
      "DrivePosition": <DrivePosition>,
      "InstallationPosition": <InstallationPosition>,
      "LockingMechanism": <LockingMechanism>,
      "Voltage": <Voltage>,
      "DriveType": <DriveType>,
      "TypeOfInstallation": <TypeOfInstallation>,
      "GeometricArea": <GeometricArea>,
      "CalcVentilation": <CalcVentilation>,
      "SpecificExhaustDimension": <SpecificExhaustDimension>,
      "BuildingDepth": <BuildingDepth>,
      "CalculationTypeForVentilation": <CalculationTypeForVentilation>,
      "HeightOfProfile": <HeightOfProfile>,
      "HeightProfileRectangleAngle1": <HeightProfileRectangleAngle1>,
      "HeightProfileRectangleAngle2": <HeightProfileRectangleAngle2>,
      "RevealDepth": <RevealDepth>,
      "RevealDepthRectangleAngle1": <RevealDepthRectangleAngle1>,
      "RevealDepthRectangleAngle2": <RevealDepthRectangleAngle2>,
      "ChainLengthConnectingRodHandle": <ChainLengthConnectingRodHandle>,
      "ApplicationName": <ApplicationName>,
      "OpeningAngle": <OpeningAngle>,
      "WeightIncGlassOrThickness": #(!WeightIncGlassOrThickness),
      "AkippOrAtilt": <AkippOrAtilt>,
      "AdrehOrAturn": <AdrehOrAturn>,
      "Ageo": <Ageo>,
      "MinPullingForceMax": <MinPullingForceMax>,
      "MinPushingForceMax": <MinPushingForceMax>,
      "MinPullingForcePermanent": <MinPullingForcePermanent>,
      "MinPushingForcePermanent": <MinPushingForcePermanent>,
      "ForceWithNegativeWind": <ForceWithNegativeWind>
    }
    """
 
  When method put
  Then status 200

  * def expectedOpeningAngle = <ExpectedOpeningAngle>
  * def actualOpeningAngle = response.OpeningAngle
  * def tolerance = 0.6
  * def lowerBound = expectedOpeningAngle - tolerance
  * def upperBound = expectedOpeningAngle + tolerance
  
  # Assert that actualOpeningAngle is within the defined range
  And assert actualOpeningAngle >= lowerBound
  And assert actualOpeningAngle <= upperBound
  
  # Check if Ageo is within the expected range
  * def expectedAgeo = <ExpectedAgeo>
  * def actualAgeo = response.Ageo
  * def toleranceAgeo = 0.5
  * def lowerBoundAgeo = expectedAgeo - toleranceAgeo
  * def upperBoundAgeo = expectedAgeo + toleranceAgeo

    # Log the values for debugging
    * karate.log('Actual Ageo:', actualAgeo)
    * karate.log('Expected Ageo:', expectedAgeo)
    * karate.log('Lower Bound Ageo:', lowerBoundAgeo)
    * karate.log('Upper Bound Ageo:', upperBoundAgeo)

    # Using separate assertions for the range check
    And assert actualAgeo >= lowerBoundAgeo
    And assert actualAgeo <= upperBoundAgeo
    

    #And match response.RequiredOpeningStroke == <ExpectedRequiredOpeningStroke>

  * def expectedRequiredOpeningStroke = <ExpectedRequiredOpeningStroke>
  * def actualRequiredOpeningStroke = response.RequiredOpeningStroke
  * def tolerance = 0.5
  * def lowerBound = expectedRequiredOpeningStroke - tolerance
  * def upperBound = expectedRequiredOpeningStroke + tolerance
  
  # Assert that actualOpeningAngle is within the defined range
  And assert actualRequiredOpeningStroke >= lowerBound
  And assert actualRequiredOpeningStroke <= upperBound
  And match response.VentWeight == <ExpectedVentWeight>

  Examples:
  | read('classpath:drivetecTestCases/features/configurations.csv') |


  