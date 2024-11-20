feature file 

Feature: Validate PDF Download
@pdfdownload
Scenario: Validate PDF is downloadable from API response

  Given url apiUrl + '/api/Drives/DownloadPDFNew/Schuco'
  And header Content-Type = 'application/json'
  And request
  """
  [
    {"Id":"configId","Header":"configId","Value":"0413f204-c057-427c-9439-44091f1470d0"},
    {"Id":"driveId","Header":"driveId","Value":"8e41b236-ddae-4821-9147-db4ac85f1b97"},
    {"Id":"culture","Header":"culture","Value":"EN-US"},
    {"Id":"projectId","Header":"projectId","Value":"9103b22a-d525-4b79-938c-4e0260bce013"},
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
    {"Id":"calculation-type-for-ventilation-area","Header":"Calculation type for ventilation area","Value":"Method under consideration of the reveal"}
  ]
  """
  When method POST
  Then status 200

  # Extract the PDF URL from the JSON response
  * def pdfUrl = response.result
  * karate.log('PDF URL:', pdfUrl)

  # Validate the URL format
  * match pdfUrl contains 'https://'
  * match pdfUrl contains '.pdf'

  # Fetch the PDF from the extracted URL
  Given url pdfUrl
  When method GET
  Then status 200

  # Validate the content type is PDF
  * match responseHeaders['Content-Type'][0] == 'application/pdf'

  # Save the PDF file locally
  * def pdfFile = response
  * karate.write(pdfFile, 'output/downloaded.pdf')

  # Assert the downloaded PDF file size is non-zero
  * def pdfSize = pdfFile.length
  * karate.log('PDF File Size:', pdfSize)
  * assert pdfSize > 0

