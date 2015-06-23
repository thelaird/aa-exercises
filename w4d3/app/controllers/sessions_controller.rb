class SessionsController < ApplicationController
  before_action :require_not_logged_in, only: [:new, :create]
  before_action :require_login, only: [:destroy, :index]

  def create
    @user = User.find_by_credentials(*user_params.values)

    if @user.nil?
      @user = User.new(user_params)
      flash.now[:errors] = ["Invalid Username or Password"]
      render :new
    else
      login_user!
    end
  end

  def new
    @user = User.new
    render :new
  end

  def destroy
    logout!(params[:id])
  end

  def index
    @sessions = current_user.sessions
    render :index
  end
end
