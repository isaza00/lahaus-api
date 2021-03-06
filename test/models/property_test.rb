require 'test_helper'

class PropertyTest < ActiveSupport::TestCase
  def setup
    @property = Property.new(user_id: 99, city:"Medellin", hood:"Belen", built_type:"Casa")
  end

  test "Should not save a property without a user_id" do
    property = Property.new(city:"Medellin", hood:"Belen", built_type:"Casa")
    assert_not property.save, "Saved a property without user ID"
  end

  test "Should not save a property without the proper built_type" do
    property = Property.new(user_id: 99, city:"Pizza", hood:"Belen", built_type:"Pizza")
    assert_not property.save, "Saved a property without an allowed built_type"
  end

  test "Should create a property" do
    property = Property.new(user_id: 99, city:"Pizza", hood:"Belen")
    assert property.save, "Saved a property without a built_type"
  end

  test "Should not save the property because admon exceeds the maximum valor" do
    property = Property.new(user_id:99, admon:5000000000000)
    assert_not property.save
  end

  test "Should not save the property because price exceeds the maximum valor" do
    property = Property.new(user_id:99, price:77777777777777777777)
    assert_not property.save
  end

  test "Should save a property because price is on the minimum-maximum valor" do
    property = Property.new(user_id:99, price:77777777777)
    assert property.save
  end

  test "Should save a property with the proper adress" do
    property = Property.new(user_id: 99, city:"Pizza", hood:"Belen", address:"Cra 50 bla bla")
    assert property.save
  end

  test "Should not save a property without the proper apt" do
    property = Property.new(user_id: 99, city:"Pizza", hood:"Belen", apt:"asdjadjasdhjasdhjasdjasdhjasdhasj")
    assert_not property.save
  end

  test "Should save a property with the proper apt" do
    property = Property.new(user_id: 99, city:"Pizza", hood:"Belen", apt:"5")
    assert property.save
  end

  test "Should save a property with the proper private_area" do
    property = Property.new(user_id: 99, city:"55555555", private_area:"SUper si")
    assert property.save
  end

  test "Should not save a property without the proper half_bathrooms" do
    property = Property.new(user_id: 99, city:"55555555", half_bathrooms:"De locos")
    assert_not property.save
  end

  test "Should  save a property with the proper half_bathrooms" do
    property = Property.new(user_id: 99, city:"55555555", half_bathrooms:"2")
    assert property.save
  end

  test "Should not save a property without the proper parking_lot" do
    property = Property.new(user_id: 99, city:"55555555", parking_lot:"Nah De locos")
    assert_not property.save
  end

  test "Should save a property with the proper parking_lot" do
    property = Property.new(user_id: 99, city:"55555555", parking_lot:"20")
    assert property.save
  end

  test "Should not save a property without the proper rent" do
    property = Property.new(user_id: 99, city:"55555555", rent:"500000000000000000000000000000000000000")
    assert_not property.save
  end

  test "Should save a property with the proper rent" do
    property = Property.new(user_id: 99, city:"55555555", rent:"5000000")
    assert property.save
  end

  test "Should create a property with admon" do
    property = Property.new(user_id:99, admon:7777777)
    assert property.save
  end

  test "Should create a property with a build_area" do
    property = Property.new(user_id:99, build_area:"hola", admon:500000)
    assert property.save
  end

  test "Should not create a property with an invalid social_class" do
    property = Property.new(user_id:99, build_area:"hola", social_class:"hola")
    assert_not property.save
  end

  test "Should create a property with a social_class" do
    property = Property.new(user_id:99, build_area:"hola", social_class:"Industrial")
    assert property.save
  end

  test "Should create a property with a state" do
    property = Property.new(user_id:99, state:"holiwis", social_class:5)
    assert property.save
  end

  test "Should create a property with a common_areas attribute" do
    property = Property.new(user_id:99, build_area:"hola", common_areas:"muchisimas")
    assert property.save
  end

  test "Should create a property with a property_tax attribute" do
    property = Property.new(user_id:99, build_area:"hola", property_tax:500000)
    assert property.save
  end

  test "Should not create a property with an invalid rooms attribute" do
    property = Property.new(user_id:99, build_area:"hola", rooms:500000)
    assert_not property.save
  end

  test "Should create a property with a valid rooms attribute" do
    property = Property.new(user_id:99, build_area:"hola", rooms:500)
    assert property.save
  end

  test "Should have successfully newd a property" do
    assert @property.save, "Didn't save a valid property"
  end

  test "Should new, save, and destroy a property" do
    property = Property.new(user_id: 99, city:"Medellin", hood:"Belen", built_type:"Casa")
    assert property.save#, "Didn't save a valid property"
    assert_equal 0, property.photos.size, "Couldn't access the property's photos"
    property = Property.find_by(user_id: 99)
    property.delete
    assert_not Property.exists?(user_id: 99), "Didn't delete the property"
  end

end
