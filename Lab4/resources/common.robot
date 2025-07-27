*** Settings ***
Library           AppiumLibrary

Variables        ../po/variables.py
Variables        ../po/locator.py




*** Keywords ***
Open Application MyApp
    Open Application       ${REMOTE_URL}   platformName=${PLATFORM_NAME}    deviceName=${DEVICE_NAME}    automationName=${AUTOMATION_NAME}    appPackage=${APP_PACKAGE}    appActivity=${APP_ACTIVITY}    noReset=true
    
Enter username
    Wait Until Element Is Visible    ${USERNAME}    5
    Click Element    ${USERNAME}
    Input Text    ${USERNAME}    admin
    
Enter password
    Wait Until Element Is Visible    ${PASSWORD}    5
    Click Element    ${PASSWORD}
    Input Password    ${PASSWORD}    admin

Log In
    Wait Until Element Is Visible    ${LOGIN}    5
    Click Element    ${LOGIN}
    Wait Until Page Contains Element    ${PAGE_FORM}

*** Keywords ***
Add New Pestore
    Click Element    ${ADD_BUTTON}
    Wait Until Page Contains Element    ${FORM_ID}    10s
    Click Element    ${FORM_ID}
    Input Text    ${FORM_ID}    2002
    Sleep    1s
    Click Element    ${FORM_NAME}
    Input Text    ${FORM_NAME}    Boote
    Sleep    1s
    Click Element    xpath=//android.widget.Button[contains(@content-desc, "Statut")]
    Sleep    2s
    Click Element    xpath=//android.widget.Button[@content-desc="pending"]
    # Click Element    xpath=//android.widget.Button[@content-desc="Statut available"]
    Sleep    1s
    Click Element    xpath=//android.widget.Button[@content-desc="Créer"]
    Log To Console    ✅ Produit ajouté avec succès !
    Sleep    2s

Search Pestore
    [Tags]    search
    Wait Until Page Contains Element    xpath=//android.widget.EditText    10s
    Click Element    xpath=//android.widget.EditText
    Input Text    xpath=//android.widget.EditText    dog
    Click Element    xpath=//android.widget.Button[@content-desc="Rechercher"]
    # Click Element    xpath=//android.widget.FrameLayout[@resource-id="android:id/content"]/android.widget.FrameLayout/android.view.View/android.view.View/android.view.View/android.view.View
    Log To Console    🔍 Recherche de produits effectuée avec succès !

# Add New Product
#     Wait Until Page Contains Element    ${FORM_TITLE}    10s
#     Click Element    ${FORM_TITLE}
#     Input Text    ${FORM_TITLE}    Maffe
#     Sleep    1s
#     Click Element    ${FORM_PRICE}
#     Input Text    ${FORM_PRICE}    1000
#     Sleep    1s
#     Click Element    ${FORM_DESCRIPTION}
#     Input Text    ${FORM_DESCRIPTION}    Le Maffe est un plat traditionnel sénégalais.
#     Sleep    1s
#     Click Element    ${FORM_CATEGORIE}
#     Input Text    ${FORM_CATEGORIE}    Viandes
#     Sleep    1s
#     Click Element    ${FORM_URL}
#     Input Text    ${FORM_URL}    http://example.com/maffe.jpg
#     Sleep    1s
#     Click Element    ${FORM_BUTTON_ADD}
#     Log To Console    ✅ Produit ajouté via formulaire mobile !
#     Sleep    2s


# View Product 
#     Wait Until Page Contains Element    xpath=//android.widget.ImageView[@content-desc="Fjallraven - Foldsack No. 1 Backpack, Fits 15 Laptops\n109.95 $"]    10s
#     Click Element    xpath=//android.widget.ImageView[@content-desc="Fjallraven - Foldsack No. 1 Backpack, Fits 15 Laptops\n109.95 $"]
#     Log To Console    🧳 Produit Fjallraven cliqué avec succès !
#     Sleep    2s

# Get Product by Id
#     ${response}=    Get Request    ${BASE_URL}/products/1    headers=${HEADERS}
#     Should Be Equal As Strings    ${response.status_code}    200
#     Log To Console    ✅ Produit récupéré avec succès : ${response.json()}


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
    
    


