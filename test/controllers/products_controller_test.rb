require "test_helper"

class ProductsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = User.create(name: "Admin", email: "admin@test.com", password: "password", admin: true)
    post "/sessions.json", params: { email: "admin@test.com", password: "password" }
    data = JSON.parse(response.body)
    @jwt = data["jwt"]
  end

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
      post "/products.json",
        headers: { "Authorization" => "Bearer #{@jwt}" },
        params: { price: 1, name: "test product", description: "test description", supplier_id: Supplier.first.id }
      data = JSON.parse(response.body)
      assert_response 200
      refute_nil data["id"]
      assert_equal "test product", data["name"]
      assert_equal "$1.00", data["formatted_price"]
      assert_equal "test description", data["description"]
    end

    assert_difference "Product.count", 0 do
      post "/products.json",
        headers: { "Authorization" => "Bearer #{@jwt}" },
        params: {}
      assert_response 422
    end

    assert_difference "Product.count", 0 do
      post "/products.json", params: {}
      assert_response 401
    end
  end

  test "update" do
    product = Product.first
    patch "/products/#{product.id}.json",
      headers: { "Authorization" => "Bearer #{@jwt}" },
      params: { name: "Updated name" }
    assert_response 200

    data = JSON.parse(response.body)
    assert_equal "Updated name", data["name"]
    assert_equal product.description, data["description"]

    patch "/products/#{product.id}.json",
      headers: { "Authorization" => "Bearer #{@jwt}" },
      params: { name: "" }
    assert_response 422

    patch "/products/#{product.id}.json",
      params: { name: "" }
    assert_response 401
  end

  test "destroy" do
    assert_difference "Product.count", -1 do
      delete "/products/#{Product.first.id}.json", headers: { "Authorization" => "Bearer #{@jwt}" }
      assert_response 200
    end

    assert_difference "Product.count", 0 do
      delete "/products/#{Product.first.id}.json"
      assert_response 401
    end
  end
end
