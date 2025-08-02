*** Settings ***

Resource   ../ressources/fakestore_keywordsF.robot

*** Variables ***
${valid_product}    {'title': 'T-shirt Africain', 'price': 40.0, 'description': 'Traditionnel tissu bogolan', 'category': 'clothing', 'image': 'https://image.url'}

*** Test Cases ***
Create Product - Success
    Create Product In MongoDB Without Helper File
    # Create Product - Fail Missing Field
    # Create Product - Fail Invalid Price Type
    # Read Product - Fail Not Found
