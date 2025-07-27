*** Settings ***

Resource   ../ressources/fakestore_keywordsF.robot

Suite Setup    Create Fakestore Session

*** Test Cases ***

*** Test Cases ***
Create Product Successfully
    ${id}=    Create Valid Product
    Should Not Be Empty    ${id}

Create Product Without Title
    Create Product Missing Title

Create Product With Invalid Type
    Create Product Invalid Type

Get Product Successfully
    ${product}=    Get Existing Product    5
    Should Be Equal As Integers    ${product["id"]}    5
    Should Contain    ${product["title"]}    Dragon

Get Product Not Found
    Get Product Not Found

Get Product Invalid ID
    Get Product Invalid ID
