feature file 

Feature: DriveTec Configurations

@drivetec
Scenario Outline: Drivetec Configurations test
 
  * def datasetName = '<DatasetName>'
  * karate.log('Running test for dataset: ', datasetName)

#   * def roundAwayFromZero =
#   """
# function(num) {
#   if (Math.abs(num) < 0.05) {
#     // Round very small values near zero to 0
#     return 0;
#   } else if (num < 10) {
#     // If the number is less than 10, round to two decimal places
#     return Math.round(num * 100) / 100;
#   } else if (num >= 10 && num < 1000) {
#     // If the number is between 10 and 1000, round to the nearest integer
#     return Math.round(num);
#   } else {
#     // For larger numbers, round to the nearest integer as well
#     return Math.round(num);
#   }
# }
#   """

* def roundAwayFromZero =
"""
function(num) {
  if (Math.abs(num) < 0.05) {
    // Round very small values near zero to 0
    return 0;
  }
  
  else if (num < 10) {
    // Round to two decimal places for numbers less than 10
    return Math.round(num * 100) / 100;
  } else if (num >= 10 && num < 1000) {
    // Round to nearest integer for numbers between 10 and 1000
    return Math.round(num);
  } else {
    // Round larger numbers to nearest integer
    return Math.round(num);
  }
}
"""

    # Custom rounding function to round values away from zero
    # * def roundAwayFromZero = 
    # """
    #   function(num) {
    #     var factor = 100;  // Scale for two decimal places
    #     var roundedNum = Math.round(num * factor) / factor;  // Round to two decimal places
    #     if (num >= 0) {
    #       return roundedNum;  // Positive numbers are rounded normally
    #     } else {
    #       return -(Math.round(Math.abs(num) * factor) / factor);  // Handle negative numbers similarly
    #     }
    #   }
    
    # """
   
#     * def roundAwayFromZero =
# """
# function(num) {
#   var factor = 100;  // Scale to capture two decimal places
#   var scaledNum = num * factor;
#   var roundedNum = Math.ceil(Math.abs(scaledNum)) / factor;  // Always round up

#   // Adjust for positive or negative values
#   if (num >= 0) {
#     return roundedNum;  // Return the rounded value directly for positive numbers
#   } else {
#     return -roundedNum;  // Negate for negative numbers
#   }
# }
# """


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
  * def roundedOpeningAngle = roundAwayFromZero(response.OpeningAngle)
  * def roundedAgeo = roundAwayFromZero(response.Ageo)
  * def roundedRequiredOpeningStroke = roundAwayFromZero(response.RequiredOpeningStroke)
  * def roundedVentWeight = roundAwayFromZero(response.VentWeight)

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