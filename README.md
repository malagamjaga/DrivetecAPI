**DriveTec API Automation Framework**

Table of Contents
Project Overview
Project Structure
Prerequisites
Setup Instructions
Configuration
Running Tests
Reports
Troubleshooting

**1. Project Overview**
This project is designed to automate API testing for the DriveTec application using the Karate Framework. It provides the following features:

Environment-based configurations (dev/stage).
JSON schema validation.
Dynamic project ID handling for create/delete operations.
Customizable parallel test execution.
Automatically generated detailed test reports in Cucumber HTML format.

**2. Project Structure**
Below is the directory structure of the project:

project/  
├── src/  
│   ├── test/java/drivetecTestCases/  
│   │   ├── createProject.feature  
│   │   ├── deleteProject.feature  
│   │   └── schemaValidation.feature  
│   ├── test/resources/  
│   │   └── karate-config.js  
├── target/  
│   └── karate-reports/  
├── pom.xml  
├── README.md  
└── TestRunner.java  
3. Prerequisites
Ensure you have the following installed:

Java JDK (Version 17.0.2)
Maven (3.6 )
VS Code with the following extensions:
Java Extension Pack
Debugger for Java
Maven for Java

**4. Setup Instructions**
Clone the Repository
If the project is hosted on a Git repository:
git clone <repository-url>  
cd <project-folder>  

Install Dependencies
Run the following Maven command to install all required dependencies:
mvn clean install  

**5. Configuration**
karate-config.js
This file handles environment-based configurations dynamically. Modify it if new environments are added:

function fn() {  
  var env = karate.env; // get system property 'karate.env'  
  karate.log('karate.env system property was:', env);  

  if (!env) {  
    env = 'dev'; // default environment  
  }  

  var config = {  
    apiUrl: 'https://dev-drivetec-apis.schuecodigitalsolutions.com',  
  };  

  if (env === 'stage') {  
    config.apiUrl = 'https://stage-drivetec-apis.schuecodigitalsolutions.com';  
  }  

  karate.configure('ssl', true); // enable SSL configuration if required  
  return config;  
} 

pom.xml
The Maven POM file includes dependencies for Karate and Cucumber reporting. Ensure these dependencies are up to date:

Key Dependencies
xml
Copy code
<dependencies>  
    <dependency>  
        <groupId>io.karatelabs</groupId>  
        <artifactId>karate-junit5</artifactId>  
        <version>${karate.version}</version>  
        <scope>test</scope>  
    </dependency>  
    <dependency>  
        <groupId>net.masterthought</groupId>  
        <artifactId>cucumber-reporting</artifactId>  
        <version>5.8.2</version>  
    </dependency>  
</dependencies>  

**6. Running Tests**
Execute All Tests
Run all tests in parallel using:
mvn test  
Execute Specific Tests by Tags
For example, to run tests tagged with @proj and @ProjDelete:

mvn test -Dkarate.options="--tags @proj,@ProjDelete"  
mvn test -Dkarate.options="--tags @drivetec" 
Execute in Parallel
Parallel execution is configured in the TestRunner.java:

Results results = Runner.path("classpath:drivetecTestCases")  
    .outputCucumberJson(true)  
    .parallel(1); // Change the number for parallel threads  
    
**7. Reports**
Cucumber HTML Report
Reports are generated automatically after execution in:

target/karate-reports/  
Custom Report Generation
Custom reports can be generated using the TestRunner.java class:

Code to Generate Reports
java
Copy code
public static void generateReport(String karateOutputPath) {  
    Collection<File> jsonFiles = FileUtils.listFiles(new File(karateOutputPath), new String[]{"json"}, true);  
    List<String> jsonPaths = new ArrayList<>(jsonFiles.size());  
    jsonFiles.forEach(file -> jsonPaths.add(file.getAbsolutePath()));  
    Configuration config = new Configuration(new File("target"), "drivetecTestCases");  
    ReportBuilder reportBuilder = new ReportBuilder(jsonPaths, config);  
    reportBuilder.generateReports();  
}  
Run the TestRunner class to generate reports.

**8. Troubleshooting**
Common Issues
karate.env is null
Ensure you pass the environment variable while running tests:

mvn test -Dkarate.env=stage  
Dependency Issues
Check that all dependencies are properly defined in pom.xml.
Run mvn clean install to re-download dependencies.
Reports Not Generated
Verify the JSON files are being generated in the target/karate-reports directory.
Ensure outputCucumberJson(true) is set in the TestRunner.
SSL Errors
Enable SSL handling in karate-config.js:
karate.configure('ssl', true);  
