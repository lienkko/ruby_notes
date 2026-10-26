require "test_helper"

class RegistrationsTest < ActionDispatch::IntegrationTest
  test "user can register and sees logged-in status" do
    assert_difference("User.count", 1) do
      post register_path, params: {
        user: {
          email: "new@example.com",
          password: "password123",
          password_confirmation: "password123"
        }
      }
    end

    assert_redirected_to root_path
    follow_redirect!
    assert_includes response.body, "Вы залогинены как"
    assert_includes response.body, "new@example.com"
  end
end