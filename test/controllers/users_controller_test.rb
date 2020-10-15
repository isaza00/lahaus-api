require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest

  setup do
    post "/api/v1/login", params: { email: "ejemplo1@mail.com", password: "1234" }
    @user_token = JSON.parse(@response.body)["token"]
    post "/api/v1/login", params: { email: "admin@mail.com", password: "admin1234" }
    @admin_token = JSON.parse(@response.body)["token"]
  end

  test "Attempt accessing without logging in should fail" do
    get "/api/v1/users/1"
    assert_response :unauthorized
    assert_equal '{"message":"Please log in"}', @response.body
  end

  test "Failed sing up due to invalid email" do
    post "/api/v1/signup", params: { email: "invalid", password: "1234" }
  end

  test "Failed log in due to invalid email" do
    post "/api/v1/login", params: { email: "invalid", password: "1234" }
    assert_response :unauthorized
    assert_equal '{"errors":"Invalid username or password"}', @response.body
  end

  test "Failed log in due to empty parameters" do
    post "/api/v1/login"
    assert_response :unauthorized
    assert_equal '{"errors":"Invalid username or password"}', @response.body
  end

  test "unauthorized for user for index" do
    get "/api/v1/users", headers: {"Authorization": "Bearer #{@user_token}" }
    assert_response :unauthorized
    assert_equal '{"message":"Unauthorized"}', @response.body
  end

  test "authorized for admin for index" do
    get "/api/v1/users", headers: {"Authorization": "Bearer #{@admin_token}" }
    assert_response :ok
    assert_equal JSON.parse(@response.body)["users"].length, User.all.length
  end

  test "authorized for admin to show any user" do
    get "/api/v1/users/100", headers: {"Authorization": "Bearer #{@admin_token}" }
    assert_response :ok
    assert_equal JSON.parse(@response.body)["user"]["email"], users(:three).email
  end

  test "unauthorized user to show any other user" do
    get "/api/v1/users/101", headers: {"Authorization": "Bearer #{@user_token}" }
    assert_response :unauthorized
    assert_equal '{"message":"Unauthorized"}', @response.body
  end

  test "authorized user to show his own user" do
    get "/api/v1/users/100", headers: {"Authorization": "Bearer #{@user_token}" }
    assert_response :ok
    assert_equal JSON.parse(@response.body)["user"]["email"], users(:three).email
  end

  test "authorized for user to delete himself" do
    assert_difference('User.count', -1) do
      delete "/api/v1/users/100", headers: {"Authorization": "Bearer #{@user_token}" }
    end
    assert_response 204
  end

  test "unauthorized for user to delete another user" do
    assert_difference('User.count', 0) do
      delete "/api/v1/users/101", headers: {"Authorization": "Bearer #{@user_token}" }
    end
    assert_response :unauthorized
  end

  test "authorized for admin to delete user" do
    assert_difference('User.count', -1) do
      delete "/api/v1/users/100", headers: {"Authorization": "Bearer #{@admin_token}" }
    end
    assert_response 204
  end

  test "checks creation of new user" do
    assert_difference('User.count', +1) do
      post "/api/v1/users/", params: {email: "ejemplo2@mail.com", password: "1234", full_name: "ejemplo2", cellphone: "3001234567"}
    end
    assert_response 201
    user = JSON.parse(@response.body)["user"]
    assert_equal user["email"], "ejemplo2@mail.com"
    assert_equal user["full_name"], "ejemplo2"
    assert_equal user["cellphone"], "3001234567"
    assert_equal JSON.parse(@response.body)["token"], JWT.encode({user_id: user["id"]}, 's3cr3t')
  end

  test "check correct update of user full_name" do
    put "/api/v1/users/100/", headers: { "Authorization": "Bearer #{@user_token}" }, params: {full_name: "newname"}
    assert_response :ok
    assert_equal JSON.parse(@response.body)["full_name"], "newname"
  end

  test "Tests the update method" do
    user = users :three
    assert_equal user.full_name, "ejemplo1"
    user.update(full_name: "new_name")
    assert_response :ok
    assert_equal user.full_name, "new_name"
  end

end
