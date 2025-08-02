from pymongo import MongoClient

# client = MongoClient("mongodb+srv://lab1:passer123@lab1.5bsmorj.mongodb.net/?retryWrites=true&w=majority&appName=Lab1")
# db = client["fakeStoreDB"]
# products = db["products"]

def connect_to_db():
    uri = "mongodb+srv://lab1:passer123@lab1.5bsmorj.mongodb.net/?retryWrites=true&w=majority&appName=Lab1"
    client = MongoClient(uri)
    db = client["fakeStoreDB"]
    return db

def create_product(product_data):
    db = connect_to_db()
    result = db["products"].insert_one(product_data)
    return str(result.inserted_id)
