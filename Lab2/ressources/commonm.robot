*** Settings ***
Library    SeleniumLibrary
Library    RequestsLibrary
Library    Collections
Variables    ../pageobject/variablesm.py
Variables    ../pageobject/locatorm.py

*** Keywords ***

Ouvrir le navigateur
    Open Browser    ${BASE_URL}    Edge
    Maximize Browser Window

PRE-CONDITIONS
    Go To    ${BASE_URL}
    Sleep    2
    Page Should Contain    text=${title_home_page}
    Sleep    2



Click Login link
    Click Element    ${btnSignIn}
    Sleep    2

Type valid login credentials
    Input Text    ${inputEmailLogin}    ${USERNAME}
    Input Password    ${inputPasswordLogin}    ${PASSWORD}
    Sleep    2

Click Submit button
    Click Button    ${submitLogin}
    Sleep    2

Logout
    Click Element    ${xpathSignOut}
    Sleep    2
    Page Should Contain    text=${title_signOut}
    Sleep    2

Examine customers grid for multiple records
    Element Should Be Visible    xpath=/html/body/div/div/nav/ul/li[2]
    Page Should Contain    text=${title_customer_list}
    Sleep    2
    	
##################################################
Click New Customer button
    Click Element    ${btn_newCustomer}
    Page Should Contain    text=${title_newCustomer}
    Sleep    2

Type customer email
    Input Text    ${new_email}    ${EMAIL_CUSTOMER}
    Sleep    1
Type customer first name
    Input Text    ${new_first_name}    ${FIRST_NAME}
    Sleep    1
Type customer last name
    Input Text    ${new_last_name}    ${LAST_NAME}
    Sleep    1
Type customer city
    Input Text    ${new_city}    ${CITY}
    Sleep    1
Select customer state
    Select From List By Value    ${new_state}    ${STATE}
    Sleep    1
Select customer gender
    Click Element    ${xpath_gender}
    Sleep    1
Optionally check promotion checkbox
    Click Element    ${name_promotion}
    Sleep    1
Click Save Customer button
    Click Element    ${submit_new_customer}
    Sleep    2
    Page Should Contain    text=${title_customer_added}
    Sleep    2




