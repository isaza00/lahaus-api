require 'test_helper'

class PropertyTest < ActiveSupport::TestCase
  def setup
    @property = Property.new(user_id: 99, city:"Medellin", hood:"Belen", built_type:"Casa")
  end

  test "Should not create a property without a user_id" do
    property = Property.new(city:"Medellin", hood:"Belen", built_type:"Casa")
    assert_not property.save, "Saved a property without user ID"
  end

  test "Should not create a property without the proper built_type" do
    property = Property.new(user_id: 99, city:"Pizza", hood:"Belen", built_type:"Pizza")
    assert_not property.save, "Saved a property without an allowed built_type"
  end

  test "Should create a property" do
    property = Property.create(user_id: 99, city:"Pizza", hood:"Belen")
    assert property.save, "Saved a property without a built_type"
  end

  test "Should have successfully created a property" do
    assert @property.save, "Didn't save a valid property"
  end

  test "Should create, save, and destroy a property" do
    property = Property.new(user_id: 99, city:"Medellin", hood:"Belen", built_type:"Casa")
    assert property.save#, "Didn't save a valid property"
    assert_equal 0, property.photos.size, "Couldn't access the property's photos"
    property = Property.find_by(user_id: 99)
    property.delete
    assert_not Property.exists?(user_id: 99), "Didn't delete the property"
  end

end
