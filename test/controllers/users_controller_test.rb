require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest

  setup do
    post "/api/v1/login", params: { email: "ejemplo1@mail.com", password: "1234" }
    @user_token = JSON.parse(@response.body)["token"]
    post "/api/v1/login", params: { email: "admin@mail.com", password: "admin1234" }
    @admin_token = JSON.parse(@response.body)["token"]
  end

  test "1 Attempt accessing without logging in should fail" do
    get "/api/v1/users/1"
    assert_response :unauthorized
    assert_equal '{"message":"Please log in"}', @response.body
  end

  test "2 Failed sing up due to invalid email" do
    post "/api/v1/signup", params: { email: "invalid", password: "1234" }
  end

  test "3 Failed log in due to invalid email" do
    post "/api/v1/login", params: { email: "invalid", password: "1234" }
    assert_response :unauthorized
    assert_equal '{"errors":"Invalid username or password"}', @response.body
  end

  test "4 Failed log in due to empty parameters" do
    post "/api/v1/login"
    assert_response :unauthorized
    assert_equal '{"errors":"Invalid username or password"}', @response.body
  end

  test "5 unauthorized for user for index" do
    get "/api/v1/users", headers: {"Authorization": "Bearer #{@user_token}" }
    assert_response :unauthorized
    assert_equal '{"message":"Unauthorized"}', @response.body
  end

  test "6 authorized for admin for index" do
    get "/api/v1/users", headers: {"Authorization": "Bearer #{@admin_token}" }
    assert_response :ok
    assert_equal JSON.parse(@response.body)["users"].length, User.all.length
  end

  test "7 authorized for admin to show any user" do
    get "/api/v1/users/100", headers: {"Authorization": "Bearer #{@admin_token}" }
    assert_response :ok
    assert_equal JSON.parse(@response.body)["users"]["email"], users(:three).email
  end

  test "8 unauthorized user to show any other user" do
    get "/api/v1/users/101", headers: {"Authorization": "Bearer #{@user_token}" }
    assert_response :unauthorized
    assert_equal '{"message":"Unauthorized"}', @response.body
  end

  test "9 authorized user to show his own user" do
    get "/api/v1/users/100", headers: {"Authorization": "Bearer #{@user_token}" }
    assert_response :ok
    assert_equal JSON.parse(@response.body)["users"]["email"], users(:three).email
  end

  test "10 authorized for user to delete himself" do
    assert_difference('User.count', -1) do
      delete "/api/v1/users/100", headers: {"Authorization": "Bearer #{@user_token}" }
    end
    assert_response 204
  end

  test "11 unauthorized for user to delete another user" do
    assert_difference('User.count', 0) do
      delete "/api/v1/users/101", headers: {"Authorization": "Bearer #{@user_token}" }
    end
    assert_response :unauthorized
  end

  test "12 authorized for admin to delete user" do
    assert_difference('User.count', -1) do
      delete "/api/v1/users/100", headers: {"Authorization": "Bearer #{@admin_token}" }
    end
    assert_response 204
  end

  test "13 checks creation of new user" do
    assert_difference('User.count', +1) do
      post "/api/v1/users/", params: {email: "ejemplo2@mail.com", password: "1234", full_name: "ejemplo2", cellphone: "3001234567"}
    end
    assert_response 201
    user = JSON.parse(@response.body)["users"]
    assert_equal user["email"], "ejemplo2@mail.com"
    assert_equal user["full_name"], "ejemplo2"
    assert_equal user["cellphone"], "3001234567"
    assert_equal JSON.parse(@response.body)["token"], JWT.encode({user_id: user["id"]}, 's3cr3t')
  end

  test "14 check correct update of user full_name" do
    put "/api/v1/users/100/", headers: { "Authorization": "Bearer #{@user_token}" }, params: {full_name: "newname"}
    assert_response :ok
    assert_equal JSON.parse(@response.body)["users"]["full_name"], "newname"
  end

  test "15 Tests the update method" do
    user = users :three
    assert_equal user.full_name, "ejemplo1"
    user.update(full_name: "new_name")
    assert_response :ok
    assert_equal user.full_name, "new_name"
  end

end
