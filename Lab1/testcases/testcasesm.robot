*** Settings ***
Resource   ../ressources/commonm.robot

Suite Setup    Creation API Session


*** Test Cases ***

######################## Users #######################
Delete User
    [Documentation]    Supprime un utilisateur dans FakeAPI passant
    ${user_id}=    Set Variable    ${good_user_id}
    ${email}=    Delete User    ${user_id}
    Log To Console    ${email} a été supprimé avec succès
    Sleep    2s

Delete User Echoue
    [Documentation]    Scenario de suppression d'un utilisateur dans FakeAPI qui échoue
    ${user_id}=    Set Variable    ${fake_user_id}
    ${email}=    Delete User    ${user_id}
    Log To Console    ${email} a été supprimé avec succès
    Sleep    2s

Update User
    [Documentation]    Met à jour un utilisateur dans FakeAPI echouant
    ${user_id}=    Set Variable    ${fake_user_id}
    ${user_data}=    Create Dictionary    username=${fake_user_name}    password=${fake_user_password}    email=${fake_user_email}    
    ${email}=    Update User    ${user_id}    ${user_data}
    Log To Console    ${email} a été mis à jour avec succès

####################### Products #######################
Update Product
    [Documentation]    Met à jour un produit existant dans FakeAPI
    ${product_id}=    Set Variable    1
    ${product_data}=    Create Dictionary    title=Nouveau produit    price=50000    description= Modication de la description
    ${title}=    Update Product    ${product_id}    ${product_data}
    Log To Console    Produit mis à jour : ${title}
    Sleep    2s

Update Product non passant
    [Documentation]    Met à jour non passant
    ${product_id}=    Set Variable    1lk
    ${product_data}=    Create Dictionary    title=Nouveau produit    price=deux cent mille    description= Modication de la description
    ${title}=    Update Product    ${product_id}    ${product_data}
    Log To Console    Produit mis à jour : ${title}
    Sleep    2s


Delete Product
    [Documentation]    Supprime un produit dans FakeAPI non passant
    ${product_id}=    Set Variable    bad_product_id
    ${title}=    Delete Product    ${product_id}
    Log To Console    Produit supprimé : ${title}
    Sleep    2s

####################### Carts #######################
Update Cart
    [Documentation]    Met à jour un panier existant dans FakeAPI
    ${cart_id}=    Set Variable    5
    ${cart_data}=    Create Dictionary    userId=3    date=2023-12-10    products=${EMPTY}
    ${id}=    Update Cart    ${cart_id}    ${cart_data}
    Log To Console    Panier mis à jour : ID ${id}
    Sleep    2s
Update Cart non passant
    [Documentation]    Met à jour un panier invalides
    ${cart_id}=    Set Variable    bad_cart_id
    ${products}=    Create List    {"productId":1,"quantity":"beaucoup"}
    ${cart_data}=    Create Dictionary    userId=4    date=invalid-date    products=${products}
    ${id}=    Update Cart    ${cart_id}    ${cart_data}
    Log To Console    Panier mis à jour : ID ${id}
    Sleep    2s

Delete Cart non passant
    [Documentation]    Supprime un panier non existant
    ${cart_id}=    Set Variable    cart-faux
    ${id}=    Delete Cart    ${cart_id}
    Log To Console    Panier supprimé : ID ${id}
    Sleep    2s
