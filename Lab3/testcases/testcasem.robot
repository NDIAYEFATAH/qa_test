*** Settings ***
Resource   ../ressources/test.robot

Suite Setup    CREATE SESSION TO EBAY    alias=${ALIAS}    base_url=${BASE_URL}    headers=${OPTIONS}


*** Test Cases ***

Get shipping fulfillment fail
    GET SHIPPING FULFILLMENT FAIL    order_id=11441

Get shipping fulfillments fail
    GET SHIPPING FULFILLMENTS FAIL   order_id=11441

Create shipping fulfillment fail
    CREATE SHIPPING FULFILLMENT FAIL    order_id=11441

Delete inventory item
    DELETE INVENTORY ITEM    inventory_item_id=1212

Create inventory item
    CREATE Or Replace Inventory Item    sku=5555

Get inventory
    GET INVENTORY

Get inventory item
    GET INVENTORY ITEM