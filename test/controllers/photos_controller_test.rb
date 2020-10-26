require 'test_helper'

class PhotosControllerTest < ActionDispatch::IntegrationTest
  test "1 attemp to list photos without login" do
    get '/api/v1/users/1/properties/1/photos'
    assert_response :unauthorized
    assert_equal '{"message":"Please log in"}', @response.body
  end

end
