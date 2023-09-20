require "test_helper"

class ProductsControllerTest < ActionDispatch::IntegrationTest
  test "index" do
    get "/products.json"
    assert_response 200

    data = JSON.parse(response.body)
    assert_equal Product.count, data.length
  end

  test "show" do
    get "/products/#{Product.first.id}.json"
    assert_response 200
    data = JSON.parse(response.body)
    assert_equal ["id", "name", "price", "formatted_price", "description", "images", "tax", "total", "is_discounted?", "quantity", "supplier"], data.keys
  end

  test "create" do
    assert_difference "Product.count", 1 do
      post "/products.json", params: { name: "test", price: 10, description: "test description", supplier_id: Supplier.first.id }
      data = JSON.parse(response.body)
      assert_response 200
    end

    assert_difference "Product.count", 0 do
      post "/products.json", params: {}
      assert_response 422
    end
  end

  test "update" do
    product = Product.first
    patch "/products/#{product.id}.json", params: { name: "Updated name" }
    assert_response 200

    data = JSON.parse(response.body)
    assert_equal "Updated name", data["name"]
    patch "/products/#{product.id}.json", params: { name: "" }
    assert_response 422
  end

  test "destroy" do
    assert_difference "Product.count", -1 do
      delete "/products/#{Product.first.id}.json"
      assert_response 200
    end
  end
end
