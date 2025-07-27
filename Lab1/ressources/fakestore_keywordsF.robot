*** Settings ***
Library    SeleniumLibrary
Library    RequestsLibrary

Library    Collections
Variables    ../pageobject/variablesF.py
    

*** Keywords ***
Create Fakestore Session
    Create Session    fakestore    ${BASE_URL}    headers=${HEADERS}

Create Valid Product
    ${payload}=    Create Dictionary    title=Maffe    price=1200    description=Plat traditionnel sénégalais.    image=http://example.com/maffe.jpg    category=viandes
    ${resp}=    POST On Session    fakestore    ${PRODUCT_ENDPOINT}    json=${payload}
    Status Should Be    200    ${resp}
    ${data}=    To Json    ${resp.content}
    Log    ✅ Produit créé avec succès : ${data}
    Return From Keyword    ${data}

Create Product Missing Title
    ${payload}=    Create Dictionary    price=1200    description=Produit sans titre    image=http://example.com/no-title.jpg    category=autre
    ${resp}=    POST On Session    fakestore    ${PRODUCT_ENDPOINT}    json=${payload}
    Should Not Be Equal As Strings    ${resp.status_code}    200
    Log    ❌ Échec attendu de la création (title manquant)

Create Product Invalid Type
    ${payload}=    Create Dictionary    title=Invalide    price=gratuit    description=Erreur sur type    image=http://example.com/img.jpg    category=autre
    ${resp}=    POST On Session    fakestore    ${PRODUCT_ENDPOINT}    json=${payload}
    Should Not Be Equal As Strings    ${resp.status_code}    200
    Log    ❌ Échec attendu de la création (price invalide)

Get Existing Product
    [Arguments]    ${product_id}
    ${resp}=    GET On Session    fakestore    ${PRODUCT_ENDPOINT}/${product_id}
    Status Should Be    200    ${resp}
    ${data}=    Set Variable    ${resp.json()}
    Log To Console    ✅ Produit trouvé : ${data}
    RETURN    ${data}

Get Product Not Found
    ${resp}=    GET On Session    fakestore    ${PRODUCT_ENDPOINT}/99999
    Should Not Be Equal As Strings    ${resp.status_code}    200
    Log    ❌ Produit inexistant détecté comme prévu

Get Product Invalid ID
    ${resp}=    GET On Session    fakestore    ${PRODUCT_ENDPOINT}/abc
    Should Not Be Equal As Strings    ${resp.status_code}    200
    Log    ❌ Requête invalide traitée correctement