json.id product.id
json.name product.name
json.price product.price
json.formatted_price number_to_currency(product.price, unit: "$", precision: 2)
json.description product.description
json.images product.images
json.tax number_to_currency(product.tax, unit: "$", precision: 2)
json.total number_to_currency(product.total, unit: "$", precision: 2)
json.is_discounted? product.is_discounted?
json.quantity product.quantity
json.supplier product.supplier
json.carted_products product.carted_products
