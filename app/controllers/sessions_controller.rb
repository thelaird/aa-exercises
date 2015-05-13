class SessionsController < ApplicationController
  before_action :require_not_logged_in, only: [:new, :create]

  def create
    @user = User.find_by_credentials(*login_params.values)

    if @user.nil?
      @user = User.new(login_params)
      flash.now[:errors] = ["Invalid Username or Password"]
      render :new
    else
      login_user!(@user)
    end
  end

  def new
    @user = User.new
    render :new
  end

  def destroy
    current_user.reset_session_token!
    session[:session_token] = nil
    redirect_to new_session_url
  end

  private

  def login_params
    params.require(:user).permit(:username, :password)
  end
end
