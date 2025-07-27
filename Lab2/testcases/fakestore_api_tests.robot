*** Settings ***
Resource   ../ressources/fakestore_keywords.robot

Suite Setup    Ouvrir le navigateur




*** Test Cases ***

Home page should load
    PRE-CONDITIONS
    Click "Login" link
    Type valid login credentials
    Click "Submit" button
    Click "New Customer" button
    Type customer email
    Type customer first name
    Type customer last name
    Type customer city
    Select customer state
    Select gender
    Optionally check promotion checkbox
    Clique "Submit" button

