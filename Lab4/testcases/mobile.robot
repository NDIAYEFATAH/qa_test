*** Settings ***
Library           AppiumLibrary

Variables        ../po/variables.py
Resource         ../resources/common.robot


Suite Setup    Run Keyword    Open Application MyApp


*** Test Cases ***
Open Application and Login
    [Tags]     "init"
    Enter username
    Enter password
    Log In
    Sleep    3s
    # Add New Pestore
    # Search Pestore

# View Products
#     View Product
#     Sleep    3s
    