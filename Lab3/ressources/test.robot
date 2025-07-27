*** Settings ***
Library    RequestsLibrary
Library    Collections

*** Test Cases ***
Get List Of All Products
    Create Session    alias=fakestore    url=https://fakestoreapi.com    headers={"Content-Type": "application/json"}
    ${response}=    GET    fakestore    /products
    Status Should Be    200    ${response}
    ${products}=    Evaluate    ${response.json()}    json
    ${length}=    Get Length    ${products}
    Log    Nombre de produits : ${length}
    Should Be True    ${length} > 0
