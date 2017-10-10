@team5 @datamigration @paymentCards
Feature: Team5 : User Data Migration - Payment Cards - Success scenarios

  Scenario: Full User data must be successfully loaded into WCS when valid values for Cards are given and user must be logged in successfully
    Given users have core attributes as below
      |user|userRegType|brand|registeredCountry|personTitle|firstName|lastName|legacyUserId|email|password|gender|dateOfBirth|phn1|phn1Typ|phn2|phn2Typ|mobilePhn|mobilePhnCnt|preferredLang|preferredCur|registrationDtTm|lastUpdate|accStatus|receiveEmailPref|receiveSmsPref|regSource|pronunciations.firstName|pronunciations.lastName|pronunciations.locale|
      |user1|Full       |<brand>|GB             |Mrs        |MigCards16|MigCards16  |*           |padmajaynap*|Pa55word||15-06-2017|0044111111|PHN|||00447404891286|GB    |en_GB        |GBP         |2017-03-24T13:25:04.961Z|2017-03-24T13:40:04.961Z|Enabled|true|true |Web      |Migration1              |Test1                  |en_GB                |
    And users have payment cards as below
#      user and card columns are for internal references
      |user|card|cardToken|primary|
      |user1|  card1 |*|false|
      |user1|  card2 |*|true|
    When the data migration file is generated from above data
    Then "1" users are loaded successfully into WCS database, after the job execution
    And the response xml file is generated with "1" records
    And assert that all the values are correctly loaded into DB
    And the user "user1" is able to login successfully after migration at "registered" eSite
    And no ysync message is generated for payment cards added

  Scenario: Full User data must be successfully loaded into WCS when valid values for Cards are given for multiple users
    Given users have core attributes as below
      |user|userRegType|brand|registeredCountry|personTitle|firstName|lastName|legacyUserId|email|password|gender|dateOfBirth|phn1|phn1Typ|phn2|phn2Typ|mobilePhn|mobilePhnCnt|preferredLang|preferredCur|registrationDtTm|lastUpdate|accStatus|receiveEmailPref|receiveSmsPref|regSource|
      |user1|Full       |<brand>|GB             |Mrs        |MigCards16|MigCards16  |*           |padmajaynap*|Pa55word||15-06-2017|0044111111|PHN|||00447404891286|GB    |en_GB        |GBP         |2017-03-24T13:25:04.961Z|2017-03-24T13:40:04.961Z|Enabled|true|true |Web      |
      |user2|Full       |<brand>|IT             |Mrs        |MigCards17|MigCards17  |*           |padmajaynap*|Pa55word||15-03-2000|0044111111||||00447404891286|GB    |en_GB        |GBP         |2017-03-24T13:25:04.961Z|2017-03-24T13:40:04.961Z|Enabled|true|true |App      |
      |user3|Full       |<brand>|JP            |Mrs        |MigCards17|MigCards17  |*           |padmajaynap*|Pa55word||15-03-2000|0044111111||||00447404891286|GB    |en_GB        |GBP         |2017-03-24T13:25:04.961Z|2017-03-24T13:40:04.961Z|Enabled|true|true |App      |
      |user4|Full       |<brand>|JP            |Mrs        |MigCards17|MigCards17  |*           |padmajaynap*|Pa55word||15-03-2000|0044111111||||00447404891286|GB    |en_GB        |GBP         |2017-03-24T13:25:04.961Z|2017-03-24T13:40:04.961Z|Enabled|true|true |App      |
    And users have payment cards as below
#      user and card columns are for internal references
      |user|card|cardToken|primary|
      |user1|  card1 |*|false|
      |user1|  card2 |*|true|
      |user2|  card3 |*|true|
      |user3|  card4 |*|empty|
      |user4|  card5 |*||
    When the data migration file is generated from above data
    Then "4" users are loaded successfully into WCS database, after the job execution
    And the response xml file is generated with "4" records
    And assert that all the values are correctly loaded into DB
    And no ysync message is generated for payment cards added

    ##This will fail assertions, ignore for now - -check manually
  @bug
  Scenario: Full User data must be successfully loaded into WCS when multiple tokens are set to primary "true" : only the last token must have primary set to true
    Given users have core attributes as below
      |user|userRegType|brand|registeredCountry|personTitle|firstName|lastName|legacyUserId|email|password|gender|dateOfBirth|phn1|phn1Typ|phn2|phn2Typ|mobilePhn|mobilePhnCnt|preferredLang|preferredCur|registrationDtTm|lastUpdate|accStatus|receiveEmailPref|receiveSmsPref|regSource|
      |user1|Full       |<brand>|GB             |Mrs        |MigCards16|MigCards16  |*           |padmajaynap*|Pa55word||15-06-2017|0044111111|PHN|||00447404891286|GB    |en_GB        |GBP         |2017-03-24T13:25:04.961Z|2017-03-24T13:40:04.961Z|Enabled|true|true |Web      |
    And users have payment cards as below
#      user and card columns are for internal references
      |user|card|cardToken|primary|
      |user1|  card1 |*|true|
      |user1|  card2 |card1|true|
    When the data migration file is generated from above data
    Then "2" users are loaded successfully into WCS database, after the job execution
    And the response xml file is generated with "2" records
    And assert that all the values are correctly loaded into DB
    And no ysync message is generated for payment cards added

  Scenario: Card Update - card details must be updated successfully
    Given users have core attributes as below
      |user|userRegType|brand|registeredCountry|personTitle|firstName|lastName|legacyUserId|email|password|gender|dateOfBirth|phn1|phn1Typ|phn2|phn2Typ|mobilePhn|mobilePhnCnt|preferredLang|preferredCur|registrationDtTm|lastUpdate|accStatus|receiveEmailPref|receiveSmsPref|regSource|
      |user1|Full       |<brand>|GB             |Mrs        |MigCards16|MigCards16  |*           |padmajaynap*|Pa55word||15-06-2017|0044111111|PHN|||00447404891286|GB    |en_GB        |GBP         |2017-03-24T13:25:04.961Z|2017-03-24T13:40:04.961Z|Enabled|true|true |Web      |
    And users have payment cards as below
#      user and card columns are for internal references
      |user|card|cardToken|primary|
      |user1|  card1 |*|false|
    When the data migration file is generated from above data
    Then "1" users are loaded successfully into WCS database, after the job execution
    And the response xml file is generated with "1" records
    Given users have core attributes as below
      |user|userRegType|brand|registeredCountry|personTitle|firstName|lastName|legacyUserId|email|password|gender|dateOfBirth|phn1|phn1Typ|phn2|phn2Typ|mobilePhn|mobilePhnCnt|preferredLang|preferredCur|registrationDtTm|lastUpdate|accStatus|receiveEmailPref|receiveSmsPref|regSource|
      |user1|Full       |<brand>|GB             |Mrs        |MigCards16|MigCards16  |user1         |user1|Pa55word||15-06-2017|0044111111|PHN|||00447404891286|GB    |en_GB        |GBP         |2017-03-24T13:25:04.961Z|2017-03-25T13:40:04.961Z|Enabled|true|true |Web      |
    And users have payment cards as below
#      user and card columns are for internal references
      |user|card|cardToken|primary|
      |user1|  card2 |card1|true|
    When the data migration file is generated from above data
    Then "1" users are loaded successfully into WCS database, after the job execution
    And the response xml file is generated with "1" records
    And assert that all the values are correctly loaded into DB
    And no ysync message is generated for payment cards added

  Scenario: Card Delete - card details must be deleted successfully, if the update request do not have the existing token details
    Given users have core attributes as below
      |user|userRegType|brand|registeredCountry|personTitle|firstName|lastName|legacyUserId|email|password|gender|dateOfBirth|phn1|phn1Typ|phn2|phn2Typ|mobilePhn|mobilePhnCnt|preferredLang|preferredCur|registrationDtTm|lastUpdate|accStatus|receiveEmailPref|receiveSmsPref|regSource|
      |user1|Full       |<brand>|GB             |Mrs        |MigCards16|MigCards16  |*           |padmajaynap*|Pa55word||15-06-2017|0044111111|PHN|||00447404891286|GB    |en_GB        |GBP         |2017-03-24T13:25:04.961Z|2017-03-24T13:40:04.961Z|Enabled|true|true |Web      |
    And users have payment cards as below
#      user and card columns are for internal references
      |user|card|cardToken|primary|
      |user1|  card1 |*|false|
      |user1|  card2 |*|false|
      |user1|  card3 |*|false|
      |user1|  card4 |*|false|
      |user1|  card5 |*|false|
    When the data migration file is generated from above data
    Then "1" users are loaded successfully into WCS database, after the job execution
    And the response xml file is generated with "1" records
    Given users have core attributes as below
      |user|userRegType|brand|registeredCountry|personTitle|firstName|lastName|legacyUserId|email|password|gender|dateOfBirth|phn1|phn1Typ|phn2|phn2Typ|mobilePhn|mobilePhnCnt|preferredLang|preferredCur|registrationDtTm|lastUpdate|accStatus|receiveEmailPref|receiveSmsPref|regSource|
      |user1|Full       |<brand>|GB             |Mrs        |MigCards16|MigCards16  |user1         |user1|Pa55word||15-06-2017|0044111111|PHN|||00447404891286|GB    |en_GB        |GBP         |2017-03-24T13:25:04.961Z|2017-03-25T13:40:04.961Z|Enabled|true|true |Web      |
    And users have payment cards as below
#      user and card columns are for internal references
      |user|card|cardToken|primary|
      |user1|  card6 |card2|false|
      |user1|  card7 |card4|false|
      |user1|  card8 |card5|false|
      |user1|  card9 |*|true|
    When the data migration file is generated from above data
    Then "1" users are loaded successfully into WCS database, after the job execution
    And the response xml file is generated with "1" records
    And assert that all the values are correctly loaded into DB
    And no ysync message is generated for payment cards added

##    This is not a valid scenario , as registeredCountry will always be the same irrespective of eSite login
#  Scenario: Card Update - Add card @<brand>_GB, update @<brand>_IT
#    Given users have core attributes as below
#      |user|userRegType|brand|registeredCountry|personTitle|firstName|lastName|legacyUserId|email|password|gender|dateOfBirth|phn1|phn1Typ|phn2|phn2Typ|mobilePhn|mobilePhnCnt|preferredLang|preferredCur|registrationDtTm|lastUpdate|accStatus|receiveEmailPref|receiveSmsPref|regSource|
#      |user1|Full       |<brand>|GB             |Mrs        |MigCards16|MigCards16  |*           |padmajaynap*|Pa55word||15-06-2017|0044111111|PHN|||00447404891286|GB    |en_GB        |GBP         |2017-03-24T13:25:04.961Z|2017-03-24T13:40:04.961Z|Enabled|true|true |Web      |
#    And users have payment cards as below
##      user and card columns are for internal references
#      |user|card|cardToken|primary|
#      |user1|  card1 |*|false|
#    When the data migration file is generated from above data
#    Then "1" users are loaded successfully into WCS database, after the job execution
#    And the response xml file is generated with "1" records
#    Given users have core attributes as below
#      |user|userRegType|brand|registeredCountry|personTitle|firstName|lastName|legacyUserId|email|password|gender|dateOfBirth|phn1|phn1Typ|phn2|phn2Typ|mobilePhn|mobilePhnCnt|preferredLang|preferredCur|registrationDtTm|lastUpdate|accStatus|receiveEmailPref|receiveSmsPref|regSource|
#      |user1|Full       |<brand>|IT             |Mrs        |MigCards16|MigCards16  |user1           |user1|Pa55word||15-06-2017|0044111111|PHN|||00447404891286|GB    |en_GB        |GBP         |2017-03-24T13:25:04.961Z|2017-03-24T13:40:04.961Z|Enabled|true|true |Web      |
#    And users have payment cards as below
##      user and card columns are for internal references
#      |user|card|cardToken|primary|
#      |user1|  card2 |card1|true|
#    When the data migration file is generated from above data
#    Then "1" users are loaded successfully into WCS database, after the job execution
#    And the response xml file is generated with "1" records
#    And assert that all the values are correctly loaded into DB



