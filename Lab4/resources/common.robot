*** Settings ***
Library           AppiumLibrary

Variables        ../po/variables.py
Variables        ../po/locator.py




*** Keywords ***
Open Application MyApp
    Open Application       ${REMOTE_URL}   platformName=${PLATFORM_NAME}    deviceName=${DEVICE_NAME}    automationName=${AUTOMATION_NAME}    appPackage=${APP_PACKAGE}    appActivity=${APP_ACTIVITY}    noReset=true
    
Enter username
    Wait Until Element Is Visible    ${USERNAMES}    5
    Click Element    ${USERNAMES}
    Input Text    ${USERNAMES}    johnd
    
Enter password
    Wait Until Element Is Visible    ${PASSWORDS}    5
    Click Element    ${PASSWORDS}
    Input Password    ${PASSWORDS}    m38rmF$

Log In
    Wait Until Element Is Visible    ${LOGIN_BTN}    5
    Click Element    ${LOGIN_BTN}
    Wait Until Page Contains Element    ${PAGE_FORM}

*** Keywords ***
Add New Product
    Wait Until Page Contains Element    ${FORM_TITLES}    10s
    Click Element    ${FORM_TITLES}
    Input Text    ${FORM_TITLES}    Maffe
    Sleep    1s
    Click Element    ${FORM_PRICES}
    Input Text    ${FORM_PRICES}    1000
    Sleep    1s
    Click Element    ${FORM_DESCRIPTIONS}
    Input Text    ${FORM_DESCRIPTIONS}    Le Maffe est un plat traditionnel sénégalais.
    Sleep    1s
    Click Element    ${FORM_CATEGORIES}
    Input Text    ${FORM_CATEGORIES}    Viandes
    Sleep    1s
    Click Element    ${FROM_URLS}
    Input Text    ${FROM_URLS}    http://example.com/maffe.jpg
    Sleep    1s
    Click Element    ${FORM_BUTTON_ADDS}
    Log To Console    Produit ajouté via formulaire mobile !
    Sleep    2s

View detail Product
    Wait Until Page Contains Element    ${VIEW_PRODUCT}    10s
    Click Element    ${VIEW_PRODUCT}
    Log To Console    Produit cliqué avec succès !
    Sleep    2s

# View Product 
#     Wait Until Page Contains Element    xpath=//android.widget.ImageView[@content-desc="Fjallraven - Foldsack No. 1 Backpack, Fits 15 Laptops\n109.95 $"]    10s
#     Click Element    xpath=//android.widget.ImageView[@content-desc="Fjallraven - Foldsack No. 1 Backpack, Fits 15 Laptops\n109.95 $"]
#     Log To Console    Produit Fjallraven cliqué avec succès !
#     Sleep    2s

# Get Product by Id
#     ${response}=    Get Request    ${BASE_URL}/products/1    headers=${HEADERS}
#     Should Be Equal As Strings    ${response.status_code}    200
#     Log To Console    Produit récupéré avec succès : ${response.json()}


# Fill the Form
#     Wait Until Element Is Visible    ${P}    5
#     Click Element    ${USERNAME}
#     Input Text    ${USERNAME}    johnd

#     Wait Until Element Is Visible    ${USERNAME}    5
#     Click Element    ${USERNAME}
#     Input Text    ${USERNAME}    johnd

#     Wait Until Element Is Visible    ${USERNAME}    5
#     Click Element    ${USERNAME}
#     Input Text    ${USERNAME}    johnd

#     Wait Until Element Is Visible    ${USERNAME}    5
#     Click Element    ${USERNAME}
#     Input Text    ${USERNAME}    johnd

#     Wait Until Element Is Visible    ${USERNAME}    5
#     Click Element    ${USERNAME}
#     Input Text    ${USERNAME}    johnd
    
    


