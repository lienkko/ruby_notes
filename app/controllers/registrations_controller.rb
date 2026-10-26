class RegistrationsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      start_session(@user)
      redirect_to root_path, notice: "Регистрация выполнена."
    else
      render :new, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.expect(user: [:email, :password, :password_confirmation])
  end

  def start_session(user)
    reset_session
    session[:user_id] = user.id
  end
end