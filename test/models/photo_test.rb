require 'test_helper'

class PhotoTest < ActiveSupport::TestCase

  test "Should not create a photo without a property id" do
    photo = Photo.new(url: "http://www.zeldadeprueba.com")
    assert_not photo.save, "Saved a photo without a property id"
  end

  test "Should not create a photo without a url" do
    photo = Photo.new(property_id: 2)
    assert_not photo.save, "Saved a photo without a url"
  end

  test "Should successfully create a photo" do
    photo = Photo.new(property_id: 2, url: "http://www.zeldadeprueba.com")
    assert photo.save, "Didn't save a photo that has all the parameters correctly"
  end

  test "Should create, save and delete a property, as well as inspecting the link" do
    photo = Photo.new(property_id: 1, url: "http://www.linkdeprueba.com")
    assert photo.save, "Didn't save a valid photo entry"
    assert_equal "http://www.linkdeprueba.com", photo.url, "The saved url is different than the one given"
    photo.delete
    assert_not Photo.exists?(property_id: 1), "Didn't delete the property"
  end

end
