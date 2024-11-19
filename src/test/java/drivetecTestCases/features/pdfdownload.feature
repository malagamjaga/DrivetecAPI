feature file 


Feature: DriveTec API - Download PDF Test


@pdfdownload
Scenario: Validate PDF download URL

  Given url apiUrl + '/api/Drives/DownloadPDFNew/Schuco'
  And header Content-Type = 'application/json'
  And request 
  """
  [
    {"Id":"configId","Header":"configId","Value":"0413f204-c057-427c-9439-44091f1470d0"},
    {"Id":"driveId","Header":"driveId","Value":"07c798cb-2b88-4e23-aaec-fbdba670ac23"},
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
    {"Id":"calculation-type-for-ventilation-area","Header":"Calculation type for ventilation area","Value":"Method in accordance with ASR 3.6"}
  ]
  """
  When method post
  Then status 200

  # Extract the result URL
  * def pdfUrl = response.result
  * karate.log('PDF Download URL:', pdfUrl)

  # Validate that the URL is a valid S3 link
  And match pdfUrl contains 'https://drive-tec-dev.s3.amazonaws.com'
  And match pdfUrl contains '.pdf'
