*** Settings ***
Resource   ../ressources/fakestore_keywords.robot

Suite Setup    1. Open web browser


*** Test Cases ***

Home page should load
    PRE-CONDITIONS