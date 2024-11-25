Feature: DriveTec Configurations

@ignore
Scenario Outline: Drivetec Configurations test

  * def datasetName = '<DatasetName>'
  * karate.log('Running test for dataset: ', datasetName)

# Rounding function that rounds away from zero
* def roundAwayFromZero = 
"""
function(value, decimalPlaces) {
  
  var num = Number(value);
  if (isNaN(num)) {
    return num;  // Return as is if it's not a valid number
  }
  
  var factor = Math.pow(10, decimalPlaces);
  var valueToRound = num * factor;
  var roundedValue = (valueToRound % 1 == 0.5 || valueToRound % 1 == -0.5) ? 
    (valueToRound > 0 ? Math.floor(valueToRound) + 1 : Math.ceil(valueToRound) - 1) : 
    Math.round(valueToRound);
  
  return roundedValue / factor;
}
"""

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

# Round the response values using the custom roundAwayFromZero function
* def roundedOpeningAngle = roundAwayFromZero(response.OpeningAngle, 0)  // Round to nearest integer
* def roundedAgeo = roundAwayFromZero(response.Ageo, 2)  // Round to two decimal places
* def roundedRequiredOpeningStroke = roundAwayFromZero(response.RequiredOpeningStroke, 0)  // Round to nearest integer
* def roundedVentWeight = roundAwayFromZero(response.VentWeight, 0)  // Round to nearest integer

# Log the rounded values for debugging
* karate.log('Rounded Opening Angle:', roundedOpeningAngle)
* karate.log('Rounded Ageo:', roundedAgeo)
* karate.log('Rounded Required Opening Stroke:', roundedRequiredOpeningStroke)
* karate.log('Rounded Vent Weight:', roundedVentWeight)

# Assert the rounded values against the expected values
* def expectedOpeningAngle = <ExpectedOpeningAngle>
* def expectedAgeo = <ExpectedAgeo>
* def expectedRequiredOpeningStroke = <ExpectedRequiredOpeningStroke>
* def expectedVentWeight = <ExpectedVentWeight>

And match roundedOpeningAngle == expectedOpeningAngle
And match roundedAgeo == expectedAgeo
And match roundedRequiredOpeningStroke == expectedRequiredOpeningStroke
And match roundedVentWeight == expectedVentWeight

Examples:
| read('classpath:drivetecTestCases/features/configurations.csv') |
