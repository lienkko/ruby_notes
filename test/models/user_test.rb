require "test_helper"

class UserTest < ActiveSupport::TestCase
  test "normalizes email and stores a password digest" do
    user = User.create!(email: "  USER@EXAMPLE.COM ", password: "password123", password_confirmation: "password123")

    assert_equal "user@example.com", user.email
    assert user.password_digest.present?
    assert user.authenticate("password123")
  end

  test "requires a unique email and a password of at least eight characters" do
    User.create!(email: "user@example.com", password: "password123")
    duplicate = User.new(email: "USER@example.com", password: "short")

    assert_not duplicate.valid?
    assert_includes duplicate.errors[:email], "has already been taken"
    assert_includes duplicate.errors[:password], "is too short (minimum is 8 characters)"
  end
end