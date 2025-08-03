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

Reads Product - Fail Not Found
    ${fake_id}=    Evaluate    __import__('bson').ObjectId("000000000000000000000000")

    ${retrieved}=    Evaluate
    ...    __import__('pymongo').MongoClient(r"mongodb+srv://lab1:passer123@lab1.5bsmorj.mongodb.net/?retryWrites=true&w=majority&appName=Lab1")["fakeStoreDB"]["products"].find_one({"_id": ${fake_id}})

    Should Be Empty    ${retrieved}    Produit inexistant comme attendu

Read Product - Fail Invalid ID
    Run Keyword And Expect Error    *    Evaluate    __import__('bson').ObjectId("id_invalide")
    Log To Console    ID invalide rejeté comme attendu

Reads Product
    ${retrieved}=    Evaluate
    ...    __import__('pymongo').MongoClient(r"mongodb+srv://lab1:passer123@lab1.5bsmorj.mongodb.net/?retryWrites=true&w=majority&appName=Lab1")["fakeStoreDB"]["products"].find_one({"_id": __import__('bson').ObjectId("688cafff5b4a723e6dfcff5d")})
    Log To Console    Produit récupéré: ${retrieved}

Update Product - Success
    ${result}=    Evaluate    __import__('pymongo').MongoClient(r'''${MONGO_URI}''')["fakeStoreDB"]["products"].update_one({"_id": __import__('bson').ObjectId("688cafff5b4a723e6dfcff5d")}, {"$set": {"price": 1500}})    modules=pymongo,bson
    Should Be Equal As Integers    ${result.modified_count}    1
    Log To Console    Produit mis à jour avec succès

# Scenario non passant
Update Product - Fail Not Found
    ${update_result}=    Evaluate    __import__('pymongo').MongoClient(r'''${MONGO_URI}''')["${DB_NAME}"]["${COLLECTION}"].update_one({"_id": __import__('bson').ObjectId("000000000000000000000000")}, {"$set": {"price": 2000}})    modules=pymongo,bson

    Should Be Equal As Integers    ${update_result.matched_count}    0
    Log To Console    ❌ Aucun produit trouvé pour la mise à jour, comme attendu.


Update Product - Fail Invalid Field
    ${oid}=    Evaluate    __import__('bson').ObjectId("688cafff5b4a723e6dfcff5d")
    ${client}=    Evaluate    __import__('pymongo').MongoClient(r"mongodb+srv://lab1:passer123@lab1.5bsmorj.mongodb.net/?retryWrites=true&w=majority&appName=Lab1")
    ${env}=    Create Dictionary    client=${client}
    ${db}=    Evaluate    client["fakeStoreDB"]    namespace=${env}
    ${env2}=    Create Dictionary    db=${db}
    ${collection}=    Evaluate    db["products"]    namespace=${env2}

    ${filter}=    Create Dictionary    _id=${oid}
    ${update_fields}=    Create Dictionary    price=valeur_invalide
    ${update}=    Create Dictionary    \$set=${update_fields}

    &{env3}=    Create Dictionary    collection=${collection}    filter=${filter}    update=${update}
    ${result}=    Evaluate    collection.update_one(filter, update)    namespace=${env3}

    Should Be Equal As Integers    ${result.matched_count}    1

    &{env4}=    Create Dictionary    collection=${collection}    oid=${oid}
    ${updated}=    Evaluate    collection.find_one({"_id": oid})    namespace=${env4}
    Should Not Be Empty    ${updated}

    &{env5}=    Create Dictionary    updated=${updated}
    ${is_valid}=    Evaluate    isinstance(updated["price"], (int, float))    namespace=${env5}
    Should Be Equal    ${is_valid}    False    Le champ 'price' est invalide

# Scenario passant pour la supression
Delete Product - Success
    ${oid}=    Evaluate    __import__('bson').ObjectId("688f58a7c8654ca00bca8c7f")    modules=bson

    &{env}=    Create Dictionary    oid=${oid}
    ${deleted}=    Evaluate
    ...    __import__('pymongo').MongoClient(r"mongodb+srv://lab1:passer123@lab1.5bsmorj.mongodb.net/?retryWrites=true&w=majority&appName=Lab1")["fakeStoreDB"]["products"].delete_one({"_id": oid}).deleted_count
    ...    namespace=${env}

    Should Be Equal As Integers    ${deleted}    1
    Log To Console    Produit supprimé avec succès : ${oid}


# Scenario non passant 
Delete Product - Fail Not Found
    ${oid}=    Evaluate    __import__('bson').ObjectId("000000000000000000000000")    modules=bson

    &{env}=    Create Dictionary    oid=${oid}
    ${deleted}=    Evaluate
    ...    __import__('pymongo').MongoClient(r"mongodb+srv://lab1:passer123@lab1.5bsmorj.mongodb.net/?retryWrites=true&w=majority&appName=Lab1")["fakeStoreDB"]["products"].delete_one({"_id": oid}).deleted_count
    ...    namespace=${env}

    Should Be Equal As Integers    ${deleted}    0    ❌ Aucun produit supprimé ID inexistant
    Log To Console    Aucun produit trouvé avec l'ID : ${oid}

Delete Product - Fail Invalid ID
    Run Keyword And Expect Error    *is not a valid ObjectId*    Evaluate
    ...    __import__('bson').ObjectId("id_invalide")    modules=bson
    Log To Console    ID invalide pour suppression

