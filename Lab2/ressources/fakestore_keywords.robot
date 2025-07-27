*** Settings ***
Library    SeleniumLibrary
Library    RequestsLibrary
Library    Collections
Variables    ../pageobject/variables.py

*** Keywords ***

Ouvrir le navigateur
    Open Browser    ${JENKINS_URL}    Edge

PRE-CONDITIONS
    Sleep    2
    Page Should Contain    Customers Are Priority One!
    Sleep    2


Click "Login" link
    Click Element    id=SignIn
    Sleep    2

Type valid login credentials
    Input Text    id=email-id    ${USERNAME}
    Input Password    id=password    ${PASSWORD}
    Sleep    2

Click "Submit" button
    Click Button    name=submit-name
    Sleep    2


Click "New Customer" button
    Click Element    id=new-customer
    Page Should Contain    Add Customer
    Sleep    2

Type customer email
    Input Text    id=EmailAddress    fatahndiaye234@gmail.com
    Sleep    1

Type customer first name
    Input Text    id=FirstName    Abdou
    Sleep    1

Type customer last name
    Input Text    id=LastName    Ndiaye
    Sleep    1

Type customer city
    Input Text    id=City    New York
    Sleep    1

Select customer state
    Select From List By Value    id=StateOrRegion    AL
    Sleep    1

Select gender
    Click Element    //*[@id="loginform"]/div/div/div/div/form/div[6]/input[1]
    Sleep    1

Optionally check promotion checkbox
    Click Element    name=promos-name
    Sleep    1

Clique "Submit" button
    Click Button    //*[@id="loginform"]/div/div/div/div/form/button
    Sleep    2
    Close Browser