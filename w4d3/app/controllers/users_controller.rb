class UsersController < ApplicationController
  before_action :require_not_logged_in

  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      login_user!
    else
      flash.now[:errors] = @user.errors.full_messages
      render :new
    end
  end
end
