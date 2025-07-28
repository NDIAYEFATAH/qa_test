*** Settings ***
Resource   ../ressources/commonm.robot

Suite Setup    Ouvrir le navigateur

Suite Teardown    Close All Browsers

*** Test Cases ***

Should be able to log out
    [Documentation]    Vérifie que l'utilisateur peut se déconnecter avec succès.
    [Tags]    Functional
    PRE-CONDITIONS
    Click Login link
    Type valid login credentials
    Click Submit button
    Logout

Customers page should display multiple customers
    [Documentation]    Vérifie que la page des clients affiche plusieurs enregistrements.
    [Tags]    smoke
    PRE-CONDITIONS
    Click Login link
    Type valid login credentials
    Click Submit button
    Examine customers grid for multiple records
    Log To Console    Customers grid est visible avec plusieurs enregistrements
    

Should be able to add new customer	
    [Documentation]    Vérifie que l'utilisateur peut ajouter un nouveau client avec succès.
    [Tags]    smoke
    # PRE-CONDITIONS
    # Click Login link
    # Type valid login credentials
    # Click Submit button
    Click New Customer button
    Type customer email
    Type customer first name
    Type customer last name
    Type customer city
    Select customer state
    Select customer gender
    Optionally check promotion checkbox
    Click Save Customer button

Should be able to cancel adding new customer	
    [Documentation]    Vérifie que l'utilisateur peut annuler l'ajout d'un nouveau client.
    [Tags]    Functional
    Click New Customer button
    Click Element    ${btn_cancelNewCustomer}
    Sleep    2
    Page Should Contain    text=${title_customer_list}

