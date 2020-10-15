require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
    @user = User.create(email: "valid@email.com", password: "1234", full_name: "valid", cellphone: "3001234567")
  end

  test "should not save user without email" do
    user = User.new(password: "1234", full_name: "valid", cellphone: "3001234567")
    assert_not user.save, "Saved the user without a email"
  end

  test "should not save user without proper email" do
    user = User.new(email: "notanactualeimail", password: "1234", full_name: "valid", cellphone: "3001234567")
    assert_not user.save, "Saved the user without an actual email"
  end

  test "should not save user with an email longer than 255 characters" do
    user = User.new(email: "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa@email.com", password: "1234", full_name: "valid", cellphone: "3001234567")
    assert_not user.save, "Saved the user with an email longer than 255 characters"
  end

  test "should not save user without a password" do
    user = User.new(email: "valid@email.com", full_name: "valid", cellphone: "3001234567")
    assert_not user.save, "Saved the user without a password"
  end

  test "should not save user with a password no longer than 4 characters" do
    user = User.new(email: "valid@email.com", password: "123", full_name: "valid", cellphone: "3001234567")
    assert_not user.save, "Saved the user with password too short"
  end

  test "should create a new user" do
    assert User.create(email: "valid1@email.com", password: "1234"), "Didn't save a properly created user"
  end

  test "should find the new created user" do
    assert User.exists?(email: "valid@email.com"), "Didn't find the created user"
  end

  test "should NOT create a user with a repeated email" do
    user = User.create(email: "valid@email.com", password: "1234", full_name: "valid", cellphone: "3001234567")
    assert_not user.valid?, "Saved an already existing user"
  end

  test "Should be capable of accessing the amount of properties a user has" do
    assert_equal 0, @user.properties.size, "Not capable of accessing the users properties"
  end

  test "Successfully create and destroy a user" do
    User.create(email: "valid1@email.com", password: "1234", full_name: "valid", cellphone: "3001234567")
    assert User.exists?(email: "valid1@email.com"), "Didn't find the created user"
    user = User.find_by(email: "valid1@email.com")
    user.destroy
    assert_not User.exists?(email: "valid1@email.com"), "Didn't destroy the created user"
  end

  def teardown
    @user.destroy
  end

end
