json.id product.id
json.name product.name
json.price number_to_currency(product.price, unit: "$", precision: 2)
json.description product.description
json.image_url product.image_url
json.tax number_to_currency(product.tax, unit: "$", precision: 2)
json.total number_to_currency(product.total, unit: "$", precision: 2)
json.is_discounted? product.is_discounted?
json.quantity product.quantity
