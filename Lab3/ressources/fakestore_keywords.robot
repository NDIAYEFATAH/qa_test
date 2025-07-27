*** Settings ***
Library    SeleniumLibrary
Library    RequestsLibrary
Library    Collections
Variables    ../pageobject/variables.py

*** Keywords ***

1. Open web browser
    Open Browser    ${JENKINS_URL}    chrome

PRE-CONDITIONS
    Sleep    2
    Page Should Contain    Customers Are Priority One!
    Sleep    2
    Close Browser