*** Settings ***
Library    SeleniumLibrary
Library    RequestsLibrary
Library    Collections
Variables    ../pageobject/variablesm.py

*** Keywords ***

Creation API Session
    Create Session    ${ALIAS}    ${API_URL}    headers=${HEADERS}
    Log To Console    Session creer avec l'API: ${API_URL}


Update User
    [Arguments]    ${user_id}    ${user_data}
    ${response}=    PUT On Session    ${ALIAS}    /users/${user_id}    json=${user_data}
    Should Be True    ${response.ok}    Erreur with status code ${response.status_code}
    RETURN    ${response.json()['email']}

Delete User
    [Arguments]    ${user_id}
    ${response}=    DELETE On Session    ${ALIAS}    /users/${user_id}
    Should Be Equal As Strings    ${response.status_code}    200
    RETURN    ${response.json()['email']}

Update Product
    [Arguments]    ${product_id}    ${product_data}
    ${response}=    PUT On Session    ${ALIAS}    /products/${product_id}    json=${product_data}
    Should Be True    ${response.ok}    FakeAPI call failed with status code ${response.status_code}
    RETURN    ${response.json()['title']}

Delete Product
    [Arguments]    ${product_id}
    ${response}=    DELETE On Session    ${ALIAS}    /products/${product_id}
    Should Be Equal As Strings    ${response.status_code}    200
    RETURN    ${response.json()['title']}

Update Cart
    [Arguments]    ${cart_id}    ${cart_data}
    ${response}=    PUT On Session    ${ALIAS}    /carts/${cart_id}    json=${cart_data}
    Should Be True    ${response.ok}    FakeAPI call failed with status code ${response.status_code}
    RETURN    ${response.json()['id']}

Delete Cart
    [Arguments]    ${cart_id}
    ${response}=    DELETE On Session    ${ALIAS}    /carts/${cart_id}
    Should Be Equal As Strings    ${response.status_code}    200
    RETURN    ${response.json()['id']}