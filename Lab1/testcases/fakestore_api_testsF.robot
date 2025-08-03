*** Settings ***

Resource   ../ressources/fakestore_keywordsF.robot

*** Variables ***
${valid_product}    {'title': 'T-shirt Africain', 'price': 40.0, 'description': 'Traditionnel tissu bogolan', 'category': 'clothing', 'image': 'https://image.url'}

*** Test Cases ***
Create Product - Success
    # Create Product In MongoDB Without Helper File
    # Create Product - Fail Missing Field
    # Create Product - Fail Invalid Price Type
    # Reads Product - Fail Not Found
    # Read Product - Fail Invalid ID
    # Reads Product
    # Update Product - Success
    # Update Product - Fail Not Found
    # Update Product - Fail Invalid Field
    # Delete Product - Success
    # Delete Product - Fail Not Found
    Delete Product - Fail Invalid ID