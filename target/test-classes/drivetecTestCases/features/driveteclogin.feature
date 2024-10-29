Feature: DriveTec Configurations




@drivetec
Scenario Outline: Drivetec Configurations test
 

  Given url apiUrl + '/Configurations'
  * def testData = read('classpath:drivetecTestCases/features/configurations.csv')
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

  And match response.RequiredOpeningStroke == <ExpectedRequiredOpeningStroke>
  And match response.VentWeight == <ExpectedVentWeight>
  And match response.OpeningAngle == <ExpectedOpeningAngle>
  And match response.Ageo == <ExpectedAgeo>
  

  
  Examples:
| read('classpath:drivetecTestCases/features/configurations.csv') |

