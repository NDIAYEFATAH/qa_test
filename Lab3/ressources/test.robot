*** Settings ***
Library           RequestsLibrary
Library           Collections
Variables         ../pageobject/variablem.py

*** Keywords ***

CREATE SESSION TO EBAY
    [Documentation]    Création d’une session pour l’API eBay
    [Arguments]    ${alias}    ${base_url}    ${headers}
    Create Session    ${alias}    ${base_url}    headers=${headers}
CREATE SHIPPING FULFILLMENT FAIL
    [Documentation]    Échec attendu lors de la création d’un shipping fulfillment
    [Arguments]    ${order_id}
    ${payload}=        Create Dictionary
    ...                order_id=${order_id}
    ...                shipping_fulfillment={"tracking_number": "1234567890", "carrier_code": "USPS"}
    ${response}=       POST On Session    ${ALIAS}    /sell/fulfillment/v1/order/${order_id}/shipping_fulfillment    json=${payload}
    Should Be Equal As Strings    ${response.status_code}    400
    Log To Console     ${response.json()}

GET SHIPPING FULFILLMENT FAIL
    [Documentation]    Échec attendu lors de la récupération d’un shipping fulfillment précis
    [Arguments]    ${order_id}
    ${fulfillment_id}=     Set Variable    fail_fillment
    ${response}=       GET On Session    ${ALIAS}    /sell/fulfillment/v1/order/${order_id}/shipping_fulfillment/${fulfillment_id}
    Should Be Equal As Strings    ${response.status_code}    400
    Log To Console     ${response.json()}

GET SHIPPING FULFILLMENTS FAIL
    [Documentation]    Échec attendu lors de la récupération de tous les shipping fulfillments
    [Arguments]    ${order_id}
    ${response}=       GET On Session    ${ALIAS}    /sell/fulfillment/v1/order/${order_id}/shipping_fulfillment
    Should Be Equal As Strings    ${response.status_code}    400
    Log To Console     ${response.json()}

GET INVENTORY
    [Documentation]    Recupération de l’inventaire
    ${response}=       GET On Session    ${ALIAS}    /sell/inventory/v1/inventory_item
    Should Be Equal As Strings    ${response.status_code}    200
    Log To Console     ${response.json()}

GET INVENTORY ITEM
    [Documentation]    Récupération d’un item d’inventaire
    ${inventory_item_id}=    Set Variable    1212
    Create Session     ${ALIAS}    ${BASE_URL}    headers=${OPTIONSInvent}
    ${response}=       GET On Session    ${ALIAS}    /sell/inventory/v1/inventory_item/${inventory_item_id}
    Should Be Equal As Strings    ${response.status_code}    200
    Log To Console     ${response.json()}

DELETE INVENTORY ITEM
    [Documentation]    Suppression d’un item d’inventaire
    [Arguments]    ${inventory_item_id}
    Create Session     ${ALIAS}    ${BASE_URL}    headers=${OPTIONSInvent}
    ${response}=       DELETE On Session    ${ALIAS}    /sell/inventory/v1/inventory_item/${inventory_item_id}
    Should Be Equal As Strings    ${response.status_code}    204
    Log To Console     ${response.json()}

CREATE Or Replace Inventory Item
    [Documentation]    Test to create or replace an inventory item
    [Arguments]    ${sku}
    Create Session    ${ALIAS}    ${BASE_URL}    headers=${OPTIONS}
    ${payload}=    Create Dictionary
    ...    product=
    ...    condition=NEW
    ...    packageWeightAndSize=[]
    ...    availability=[]

    ${product}=    Create Dictionary
    ...    title=Test listing - do not bid or buy - awesome Apple watch test 2
    ...    description=Test listing - do not bid or buy \n Built-in GPS. Water resistance to 50 meters. A new lightning-fast dual-core processor. ...
    ...    upc=888462079525
    ...    aspects=[]
    ...    imageUrls=[]

    Set To Dictionary    ${payload}    product=${product}

    ${dimensions}=    Create Dictionary
    ...    height=5
    ...    length=10
    ...    width=15
    ...    unit=INCH
    ${package}=    Create Dictionary
    ...    dimensions=${dimensions}
    ...    packageType=MAILING_BOX
    Set To Dictionary    ${payload}    packageWeightAndSize=${package}

    ${availability}=    Create Dictionary
    ...    shipToLocationAvailability=${None}
    Set To Dictionary    ${payload}    availability=${availability}

    ${response}=    PUT On Session    ${ALIAS}    /sell/inventory/v1/inventory_item/${sku}    json=${payload}
    Should Be Equal As Strings    ${response.status_code}    204
    Log To Console    Inventory Item Updated Successfully
