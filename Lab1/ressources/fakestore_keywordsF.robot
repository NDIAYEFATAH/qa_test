*** Settings ***
Library    SeleniumLibrary
Library    RequestsLibrary
Library    Collections
Library    OperatingSystem
Library    String
# Variables    ../pageobject/variablesF.py
Library    ../ressources/connectDB.py

*** Variables ***
${MONGO_URI}     mongodb+srv://lab1:passer123@lab1.5bsmorj.mongodb.net/?retryWrites=true&w=majority&appName=Lab1
${DB_NAME}       fakeStoreDB
${COLLECTION}    products

*** Keywords ***
# Scenario passant pour l'ajout
Create Product In MongoDB Without Helper File
    ${product}=    Create Dictionary
    ...    title=Maffe
    ...    price=1200
    ...    description=Plat sénégalais
    ...    image=http://example.com/maffe.jpg
    ...    category=viandes

    ${inserted_id}=    Evaluate
    ...    str(__import__('pymongo').MongoClient(r"mongodb+srv://lab1:passer123@lab1.5bsmorj.mongodb.net/?retryWrites=true&w=majority&appName=Lab1")["fakeStoreDB"]["products"].insert_one(${product}).inserted_id)
    Should Not Be Empty    ${inserted_id}
    Log    Produit inséré avec succès : ${inserted_id}

# Scenario non passant pour l'ajout
Create Product - Fail Missing Field
    ${product}=    Create Dictionary
    ...    price=1200
    ...    description=Plat sénégalais
    ...    image=http://example.com/maffe.jpg
    ...    category=viandes

    Dictionary Should Contain Key    ${product}    title

Create Product - Fail Invalid Price Type
    ${product}=    Create Dictionary
    ...    title=Maffe
    ...    price=prix_invalide
    ...    description=Plat sénégalais
    ...    image=http://example.com/maffe.jpg
    ...    category=viandes
    ${inserted_id}=    Evaluate
    ...    str(__import__('pymongo').MongoClient(r"mongodb+srv://lab1:passer123@lab1.5bsmorj.mongodb.net/?retryWrites=true&w=majority&appName=Lab1")["fakeStoreDB"]["products"].insert_one(${product}).inserted_id)
    ${is_valid}=    Run Keyword And Return Status    Evaluate    isinstance(${product['price']}, (int, float))
    Should Be Equal    ${is_valid}    False    Le champ 'price' doit être invalide pour ce test.


