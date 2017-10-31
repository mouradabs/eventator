@backend
Feature: Media settings
    In order to update media settings
    As an admin
    I should be able to edit media settings

Background:
    Given following "Event":
        | ref    | title          | description                | startDate        | endDate          | venue              | email               | host                      |
        | event  | My event       | My another awesome event!  | 2016-03-01 10:00 | 2016-03-01 18:00 | Burj Khalifa Tower | eventator@email.com | http://localhost:8000     |
        | event2 | My other event | My other awesome event!    | 2016-03-01 10:00 | 2016-03-01 18:00 | Burj Khalifa Tower | eventator@gmail.com | http://eventator.loc      |
    And following "EventTranslation":
        | event  | locale |
        | event  | ru_RU  |
        | event2 | ru_RU  |
    And following "Organizer":
        | ref        | title         | description                    | isActive | events              |
        | organizer  | My organizer  | My another awesome organizer!  | 1        | event,event2 |
    And following "OrganizerTranslation":
        | organizer   | locale |
        | organizer   | ru_RU  |
    And following "Speech":
        | ref     | title                | description                            | language | event        |
        | speech  | symfony propagation  | world symfony expansion                | ru       | event        |
    And following "SpeechTranslation":
        | speech   | locale |
        | speech   | ru_RU  |
    And following "Program":
        | ref             | title               | isTopic | isActive | startDate         | endDate           | events       | speech  |
        | program         | keynote             | 1       | 1        | 2016-03-01 10:00  | 2016-03-01 10:30  | event        |         |
    And following "ProgramTranslation":
        | program   | locale |
        | program   | ru_RU  |
    And following "Speaker":
        | ref      | firstName | lastName  | Company          | email | homepage           | twitter                     | events              | speeches                                        |
        | speaker  | Phill     | Pilow     | Reseach Supplier |       |                    |                             | event,event2 | speech |
    And following "SpeakerTranslation":
        | speaker   | locale |
        | speaker   | ru_RU  |
    And following "Sponsor":
        | ref      | company          | description             | homepage            | type | isActive | events              |
        | sponsor  | Reseach Supplier | NASA research center    | http://nasa.gov.us  | 1    | 1        | event,event2 |
    And following "SponsorTranslation":
        | sponsor   | locale |
        | sponsor   | de_DE  |
    And following "Media":
        | title  | filename | created_date     | updated_date     |
        | Media1 | logo.png | 2017-10-27 16:02 | 2017-10-27 16:02 |
        | Media2 | logo.png | 2017-10-27 17:02 | 2017-10-27 17:02 |

@javascript
Scenario: Admin should have access to the media manage
    Given I am sign in as admin
    When I click "Media"
    Then I wait for a form
    Then I should see "Add Media"
    And I should see the row containing "1;Media1"
    And I should see the row containing "2;Media2"
    When I click "Edit" on the row containing "1;Media1"
    Then I wait for a form
    Then I should see "Media settings"

@javascript
Scenario: Admin should be able to add media
    Given I am sign in as admin
    When I click "Media"
    Then I wait for a form
    Then I should see "Add Media"
    And I click "Add Media"
    Then I wait for a form
    Then I should see "Media settings"
    And I fill in "Title" with "Media3"
    And I press "Upload file"
    Then I wait "10" seconds
    Then I should see " My Device "
    And I attach the file "test.png" to "fsp-fileUpload"
    Then I should see "Edit Image"
    Then I wait "15" seconds
    And I click on the element with css selector ".fsp-button--primary"
    Then I wait "10" seconds
    And I press "Add"
    Then I wait for a form
    Then I should see "Media Media3 added."
    Then I should see the row containing "3;Media3"

@javascript
Scenario: Admin should be able to update media settings
    Given I am sign in as admin
    When I click "Media"
    Then I wait for a form
    Then I should see "Add Media"
    And I should see the row containing "2;Media2"
    When I click "Edit" on the row containing "2;Media2"
    Then I wait for a form
    Then I should see "Media settings"
    And I fill in "Title" with "Media2_1"
    And I fill in "Media Description" with "Awesome media"
    And I fill in "Copyright Info" with "Test media"
    And I press "Update"
    Then I wait for a form
    Then I should see "Media Media2_1 updated."
    Then I should see the row containing "2;Media2_1"

@javascript
Scenario: Admin should be delete to the media
    Given I am sign in as admin
    When I click "Media"
    Then I wait for a form
    Then I should see "Add Media"
    And I should see the row containing "1;Media1"
    Then I delete the record with id "1"
    Then I wait for a form
    Then I should see "Media deleted."
    Then I should not see the row containing "1;Media1"