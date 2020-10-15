require 'test_helper'

class PropertiesControllerTest < ActionDispatch::IntegrationTest

  test "index: just authorized user" do
    get '/api/v1/users/1/properties'
    assert_response :unauthorized
    assert_equal '{"message":"Please log in"}', @response.body
  end

end
