*** Settings ***

Resource   ../ressources/commonF.robot

Suite Setup    Ouvrir le navigateur
Suite Teardown    Close Browser


*** Test Cases ***
#Id 0001 Home page should load
Id 0001 Home page should load
    PRE-CONDITIONS

Id 0002 Login should succeed with valid credentials
    Click "Login" link
    Type valid login credentials
    Click "Submit" button


Id 0003 Login should fail with missing credentials
    1. Click "Login" link
    2. Leave login credentials empty
    3. Click "Submit" button

Id 0003bis "Remember me" checkbox should persist email address
    1.Click "Login" links
    2. Type valid login credentials
    3. Click "Remember me" checkbox
    4. Click "Submit" button
    5. Click "Logout" link
    6. Click "Login" link again
