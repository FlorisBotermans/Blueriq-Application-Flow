# Blueriq ApplicationFlow

## §1 Introduction
Welcome to the documentation of the Blueriq ApplicationFlow. The main purpose of this application is to create snapshots of the database. But before this can be done, the flow of the application has to be run through to create database entries. This is done by creating payload objects. These payload objects are created with taking multiple variables into account, so that it can be implemented by different task implementations. Tests have also been written for this application to test if the flow of the application is correctly run through. See the [documentation](#4-documentation) for more detailed info.

## §2 Built with
This project is built with the following techniques:
* [Maven](https://maven.apache.org/) - Dependency Management
* [JUnit 5](https://junit.org/junit5/) - Testing Framework

## §3 Running the tests
Run the tests by using the following command:
```
mvn test
```

## §4 Documentation
### §4.1 Cleaning the database
* Before the tests are executed, the `@BeforeAll` hook will be called which empties the database. This action is needed because we want any particular test to be free from the side-effects of tests that have run before, and to not impact any tests that will run after.

### §4.2 Blueriq API
#### §4.2.1 Authentication
* To initialize a project you first need to login using the API. After sending the request you should get a `cookie` which must be used for authentication.

#### §4.2.2 Starting a new session
* After the project has been initialized a new session can be started, which returns a `sessionId` that is used in future API requests.

#### §4.2.3 Loading the session
* When a session has been created, the current state of the session can be obtained by loading the information of the provided session.
The response contains a description of the current page model. The response also contains a `CSRF-token` that is also needed in future API requests.

#### §4.2.4 Starting a flow
* After loading the session, a flow can be started. To perform this request, the name of the flow has to be specified in the request URL and the previously obtained `CSRF-token` must be provided in the request headers.

#### §4.2.5 Sending a user event
* After each sessionload, you get all the elements of the page. Based on different attributes of that element, like the dataType or the required attribute as you can see in the element example below, a payload object is created, which will be sent in the request body as you can see in the payload example below:

**Element example**
```
{
    "values": [
        "m"
    ],
    "dataType": "text",
    "refresh": false,
    "type": "field",
    "questionText": "Gender",
    "rejectedValue": null,
    "required": true,
    "explainText": null,
    "readonly": true,
    "domain": [
        {
            "displayValue": "M",
            "styles": [],
            "value": "m"
        },
        {
            "displayValue": "F",
            "styles": [],
            "value": "f"
        }
    ],
    "displayLength": -1,
    "name": "Applicant.Gender",
    "messages": [],
    "hasDomain": true,
    "styles": [],
    "validations": [
        {
            "blocking": true,
            "type": "Required",
            "message": "This is a required field.",
            "parameters": {}
        }
    ],
    "functionalKey": "P391_Applicant-Gender_1",
    "multiValued": false,
    "parameters": [],
    "properties": {},
    "key": "P391-C0-F2"
}
```

**Payload example**
```
{
    "elementKey": "P520_Submit_1",
    "fields": [
        {
            "values": [
                ""
            ],
            "key": "P520_Applicant-DateOfBirth_1"
        },
        {
            "values": [
                "text"
            ],
            "key": "P520_Applicant-SocialSecurity_1"
        },
        {
            "values": [
                "m"
            ],
            "key": "P520_Applicant-Gender_1"
        },
        {
            "values": [
                "text"
            ],
            "key": "P520_Applicant-LastName_1"
        },
        {
            "values": [
                "ElementarySchool"
            ],
            "key": "P520_Applicant-Education_1"
        },
        {
            "values": [
                "text"
            ],
            "key": "P520_Applicant-Initials_1"
        },
        {
            "values": [
                ""
            ],
            "key": "P520_Employment-Company_1"
        },
        {
            "values": [
                ""
            ],
            "key": "P520_Employment-Phone_1"
        },
        {
            "values": [
                "DenBosch"
            ],
            "key": "P520_Applicant-City_1"
        },
        {
            "values": [
                "10000"
            ],
            "key": "P520_Application-DesiredCreditLimit_1"
        },
        {
            "values": [
                "Visa"
            ],
            "key": "P520_Application-TypeOfCard_1"
        },
        {
            "values": [
                ""
            ],
            "key": "P520_Applicant-Email_1"
        },
        {
            "values": [
                "text"
            ],
            "key": "P520_Applicant-Phone_1"
        },
        {
            "values": [
                ""
            ],
            "key": "P520_Employment-YearsInCurrentEmployment_1"
        },
        {
            "values": [
                ""
            ],
            "key": "P520_Employment-CurrentPosition_1"
        },
        {
            "values": [
                ""
            ],
            "key": "P520_Employment-YearlyIncome_1"
        }
    ]
}
```
If the payload is successfully sent, a new sessionload is performed to load the new information of the session. Afterwards the expected page key is compared to the actual page key to test if the flow is correctly run through.
> For more details check the Blueriq REST API documentation here: [Blueriq REST API](https://my.blueriq.com/display/DOC/UI+REST+API+V2)

### §4.3 Snapshot creation
* After the whole flow of the application is run through and all the entries are created, a snapshot of the database is created and is then tested by this application: [Snapshot](https://github.com/chronoDave/Internship-Csv)
