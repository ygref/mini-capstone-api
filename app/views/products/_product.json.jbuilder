json.extract! product, :id, :created_at, :updated_at
json.url product_url(product, format: :json)

json.id product.id
json.name product.name
json.price product.price
json.description product.description
json.image_url product.image_url
