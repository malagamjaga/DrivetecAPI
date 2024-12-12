@Configurations
Feature: DriveTec Configurations


Scenario Outline: Drivetec Configurations Test
  
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
# Call the POST feature to create a configuration and get configId
* def postResponse = karate.call('classpath:drivetecTestCases/features/CreatePositions.feature')
* def configId = karate.get('configId') 

  Given url apiUrl + '/Configurations'
  And header Content-Type = 'application/json'
  And request
  """
  {
      "Id": "#(postResponse.configId)",
      "Name": "<Name>",
      "Description": "#(postResponse.positionName)",
      "ProjectId": "#(postResponse.projId)",
      "CustomTags": "",
      "CreatedBy": "579816e4-6653-4794-b435-a885f32e28d7",
      "ModifiedBy": "579816e4-6653-4794-b435-a885f32e28d7",
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


  * def ventWeight = response.VentWeight
  * karate.log('VentWeight from API Response:', ventWeight)

  * def updatedConfigId = karate.jsonPath(response, '$.Id')

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

* if (ventWeight > 255) karate.fail('No recommended drives found! Calculation not possible because VentWeight is greater than 255.')

# GET request >> Recomm Drives
Given url apiUrl + '/Config/' + updatedConfigId + '/Drive'
When method GET
Then status 200

# Function to normalize and clean the data (remove spaces and other invisible characters)
* def normalizeData = 
"""
function(value) {
  return value.replace(/\s+/g, ' ').trim();  // Replace multiple spaces with one and trim extra spaces
}
"""

# Function to compare two lists (ignoring spaces and order)
* def compareLists = 
"""
function(actual, expected) {
  var sortedActual = actual.split(',').map(normalizeData).sort().join(',');
  var sortedExpected = expected.split(',').map(normalizeData).sort().join(',');
  
  if (sortedActual !== sortedExpected) {
    karate.log('Comparison failed! Actual:', sortedActual, 'Expected:', sortedExpected);
  }
  
  return sortedActual == sortedExpected;
}
"""

# Extract actual RecommDrive values
* def actualRecommDrive = response.map(function(x) { return x.Name }).join(', ') 

# Normalize the actual and expected values
* def normalizedActualRecommDrive = normalizeData(actualRecommDrive)
* def normalizedExpectedRecommDrive = normalizeData('<RecommDrive>') 

# Log the normalized values for debugging
* karate.log('Normalized Actual RecommDrive:', normalizedActualRecommDrive)
* karate.log('Normalized Expected RecommDrive:', normalizedExpectedRecommDrive)

# Compare the lists (sorted and normalized)
* def isMatch = compareLists(normalizedActualRecommDrive, normalizedExpectedRecommDrive)

# Assert the result
* assert isMatch

* def driveIds = response.map(function(y) { return y.Id })
* karate.log('All Drive IDs:', driveIds)
* def firstDriveId = driveIds[0]
* karate.log('First Drive ID:', firstDriveId)

* def payload = 
"""
[
    {"Id":"configId","Header":"configId","Value":"#(updatedConfigId)"},
    {"Id":"driveId","Header":"driveId","Value":"#(firstDriveId)"},
    {"Id":"culture","Header":"culture","Value":"EN-US"},
    {"Id":"projectId","Header":"projectId","Value":"#(postResponse.projId)"},
    {"Id":"range-of-app","Header":"Range of application","Value":"Façade"},
    {"Id":"opening-type","Header":"Opening type","Value":"Bottom-hung vent"},
    {"Id":"opening-direction","Header":"Opening direction","Value":"Inward"},
    {"Id":"how-calc-weight","Header":"Vent weight","Value":"Weight including glass"},
    {"Id":"Chain-Length","Header":"Chain- / connecting rod handle","Value":"100%"},
    {"Id":"drive-position","Header":"Drive position","Value":"Side installation"},
    {"Id":"locking-mechanism","Header":"Locking mechanism","Value":"With"},
    {"Id":"voltage","Header":"Voltage","Value":"24 V"},
    {"Id":"drive-type","Header":"Drive type","Value":"Chain drive"},
    {"Id":"type-installation","Header":"Type of installation","Value":"Pivoting Outer Frame Installation"},
    {"Id":"calculation-type-for-ventilation-area","Header":"Calculation type for ventilation area","Value":"Method in accordance with ASR 3.6"}
]
"""
    
    # Call the download API
    Given url apiUrl + '/api/Drives/DownloadPDFNew/Schuco'
    And request payload
    When method POST
    Then status 200
    

# Log all download results
* karate.log('Download URL for first driveId:', response.result)

Examples:
  | read('classpath:drivetecTestCases/features/sampleconfigurations.csv') |