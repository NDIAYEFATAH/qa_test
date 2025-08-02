*** Settings ***
Library    SeleniumLibrary
Library    RequestsLibrary

Variables    ../pageobject/variablesF.py


*** Keywords ***
# id 0001 Home page should load
Ouvrir le navigateur
    Open Browser    ${JENKINS_URL}    Edge
    Maximize Browser Window
    Sleep    2

PRE-CONDITIONS
    Sleep    2
    Page Should Contain    Customers Are Priority One!
    Sleep    2

# id 0002 Login should succeed with valid credentials
Click "Login" link
    Click Element    id=${BUTTON_SIGN}
    Sleep    2

Type valid login credentials
    Input Text    id=email-id    ${USERNAME}
    Input Password    id=password    ${PASSWORD}
    Sleep    2

Click "Submit" button
    Click Button    name=submit-name
    Sleep    2

# id 0003 Login should fail with missing credentials
1. Click "Login" link
    Click Element    id=${BUTTON_SIGN}
    Sleep    2

2. Leave login credentials empty
    Input Text    id=email-id    ${USERNAME}
    Sleep    1
    Input Password    id=password    ${PASSWORD}
    Sleep    1

3. Click "Submit" button
    Click Button    name=submit-name
    Sleep    2
    Page Should Contain    Veuillez renseigner ce champ.
    Close Browser

# id 0003bis "Remember me" checkbox should persist email address
1.Click "Login" links
    Click Element    id=${BUTTON_SIGN}
    Sleep    2

2. Type valid login credentials
    Input Text    id=email-id    ${USERNAME}
    Input Password    id=password    ${PASSWORD}
    Sleep    1

3. Click "Remember me" checkbox
    Click Element    id=remember
    Sleep    1

4. Click "Submit" button
    Click Button    name=submit-name
    Sleep    2

5. Click "Logout" link
    Click Element    xpath=/html/body/nav/ul/li/a
    Page Should Contain    Thank you for using the CRM. See you next time!
    Sleep    2

6. Click "Login" link again
    Click Element    xpath=/html/body/nav/ul/li/a
    Sleep    2
