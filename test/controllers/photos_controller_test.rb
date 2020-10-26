require 'test_helper'

class PhotosControllerTest < ActionDispatch::IntegrationTest

  setup do
    post "/api/v1/login", params: { email: "ejemplo1@mail.com", password: "1234" }
    @user_token = JSON.parse(@response.body)["token"]
    post "/api/v1/login", params: { email: "ejemplo3@mail.com", password: "1234" }
    @user3_token = JSON.parse(@response.body)["token"]
    post "/api/v1/login", params: { email: "admin@mail.com", password: "admin1234" }
    @admin_token = JSON.parse(@response.body)["token"]
  end

  test "1 attemp to list photos without login" do
    get '/api/v1/users/1/properties/1/photos'
    assert_response :unauthorized
    assert_equal '{"message":"Please log in"}', @response.body
  end

  test "2 attemp to list photos of another user" do
    get '/api/v1/users/101/properties/3/photos', headers: {"Authorization": "Bearer #{@user_token}" }
    assert_response :unauthorized
    assert_equal '{"message":"Unauthorized"}', @response.body
  end

  test "3 list photos of any user by admin" do
    get '/api/v1/users/101/properties/3/photos', headers: {"Authorization": "Bearer #{@admin_token}" }
    assert_response :ok
  end

  test "4 show photo by id" do
    get '/api/v1/users/103/properties/10/photos/1', headers: {"Authorization": "Bearer #{@user3_token}" }
    assert_response :ok
    assert_equal "http://image", JSON.parse(@response.body)["photos"]["url"]
  end

  test "5 destroy photo by id" do
    assert_difference('Photo.count', -1) do
      delete '/api/v1/users/103/properties/10/photos/1', headers: {"Authorization": "Bearer #{@user3_token}" }
    end
    assert_response :ok
  end

  test "6 create photo" do
    assert_difference('Photo.count', 1) do
      post '/api/v1/users/103/properties/10/photos',
            params: { url: "http://image2" },
            headers: {"Authorization": "Bearer #{@user3_token}" }
    end
    assert_response 201
    assert_equal "http://image2", JSON.parse(@response.body)["photos"]["url"]
  end

end
