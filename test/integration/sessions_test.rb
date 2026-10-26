require "test_helper"

class SessionsTest < ActionDispatch::IntegrationTest
  setup do
    @user = User.create!(email: "user@example.com", password: "password123")
  end

  test "user can log in, keep the session after refresh, and log out" do
    post login_path, params: { email: @user.email, password: "password123" }

    assert_redirected_to root_path
    follow_redirect!
    assert_includes response.body, "Вы залогинены как"

    get root_path
    assert_includes response.body, "user@example.com"

    delete logout_path
    assert_redirected_to root_path
    follow_redirect!
    assert_includes response.body, "Вы не залогинены"
  end

  test "invalid credentials do not create a session" do
    post login_path, params: { email: @user.email, password: "wrongpass" }

    assert_response :unprocessable_entity
    assert_includes response.body, "Неверный email или пароль"
  end
end