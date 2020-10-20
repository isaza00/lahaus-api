require 'test_helper'

class PropertiesControllerTest < ActionDispatch::IntegrationTest

  setup do
    post "/api/v1/login", params: { email: "ejemplo1@mail.com", password: "1234" }
    @user_token = JSON.parse(@response.body)["token"]
    post "/api/v1/login", params: { email: "admin@mail.com", password: "admin1234" }
    @admin_token = JSON.parse(@response.body)["token"]
  end

  test "index: just authorized user" do
    get '/api/v1/users/1/properties'
    assert_response :unauthorized
    assert_equal '{"message":"Please log in"}', @response.body
  end

  test "index: enter with a loged user" do
    get '/api/v1/users/100/properties', headers: {"Authorization": "Bearer #{@user_token}" }
    assert_response :ok
    assert_equal '{"properties":[]}', @response.body
  end

  test "index: enter with admin profile" do
    get '/api/v1/users/101/properties', headers: {"Authorization": "Bearer #{@admin_token}" }
    assert_response :ok
    properties_test = @response.body
    assert_equal properties_test, @response.body
  end

  test "show: show properties without loged in" do
    get '/api/v1/users/100/properties/4'
    assert_response :unauthorized
    assert_equal '{"message":"Please log in"}', @response.body
  end

  test "show: show properties with a invalid property id" do
    get '/api/v1/users/100/properties/4', headers: {"Authorization": "Bearer #{@user_token}" }
    assert_response 404
    assert_equal '{"errors":"Couldn\'t find Property with \'id\'=4"}', @response.body
  end

  test "show: show properties with a valid property id" do
    get '/api/v1/users/100/properties/6', headers: {"Authorization": "Bearer #{@user_token}" }
    assert_response :ok
    properties_test = @response.body
    assert_equal properties_test, @response.body
  end

  test "destroy: destroy an invalid property id" do
    delete '/api/v1/users/100/properties/8', headers: {"Authorization": "Bearer #{@user_token}"}
    assert_response 404
    assert_equal '{"errors":"Couldn\'t find Property with \'id\'=8"}', @response.body
  end

  test "destroy: destroy a valid property id" do
    assert_difference('Property.count', -1) do
      delete '/api/v1/users/100/properties/7', headers: {"Authorization": "Bearer #{@user_token}"}
    end
    assert_response 200
    assert_equal "{}", @response.body
  end

  test "create: create a property with no attributes" do
    assert_difference('Property.count', +1) do
      post "/api/v1/users/100/properties/", headers: {"Authorization": "Bearer #{@user_token}"}
    end
    assert_response 201
  end

  test "create: checks the creation of a property without all the entries" do
    assert_difference('Property.count', +1) do
      post "/api/v1/users/100/properties/", headers: {"Authorization": "Bearer #{@user_token}"}, params: {built_type: "Casa", price: 5000000, admon: 80000, rooms: 3}
    end
    assert_response 201
    property = JSON.parse(@response.body)
    assert_equal property["built_type"], "Casa"
    assert_equal property["price"], "5000000"
    assert_equal property["admon"], "80000"
    assert_equal property["rooms"], "3"
  end

  test "create: checks the creation with an invalid param" do
    assert_difference('Property.count', +1) do
      post "/api/v1/users/100/properties/", headers: {"Authorization": "Bearer #{@user_token}"}, params: {city: "Medellin", ruum: 5000000, property_tax: 777777, bathrooms: 5}
    end
    assert_response 201
    property = JSON.parse(@response.body)
    puts @response.body
    assert_equal property["city"], "Medellin"
    assert_equal property["property_tax"], "777777"
    assert_equal property["bathrooms"], "5"
    assert_equal property["ruum"], nil
  end

  test "create: checks the creation with an invalid value" do
    assert_difference('Property.count', +1) do
      post "/api/v1/users/100/properties/", headers: {"Authorization": "Bearer #{@user_token}"}, params: {social_class: 3, rent: "si", half_bathrooms: 7}
    end
    assert_response 201
    property = JSON.parse(@response.body)
    puts property
    assert_equal property["social_class"], "3"
    assert_equal property["rent"], "si"
    assert_equal property["half_bathrooms"], "7"

  end

  test "check update of the city" do
    put "/api/v1/users/100/properties/1", headers: { "Authorization": "Bearer #{@user_token}" }, params: {city: "Sabaneta"}
    assert_response :ok
    assert_equal JSON.parse(@response.body)["city"], "Sabaneta"
  end

  test "check update without all the params" do
    put "/api/v1/users/100/properties/1", headers: { "Authorization": "Bearer #{@user_token}" }, params: {built_type: "Casa"}
    assert_response :ok
    assert_equal JSON.parse(@response.body)["built_type"], "Casa"
  end
end
