class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user, :current_session

  def current_user
    @current_user ||= User.find_by_session_token(session[:session_token])
  end

  def current_session
    @current_session ||= Session.find_by(session_token: session[:session_token])
  end

  def login_user!
    session[:session_token] = @user.sessions.create.session_token
    redirect_to cats_url
  end

  def logout!(id)
    @session = Session.find(id).delete
    if @session == current_session
      session[:session_token] = nil
      redirect_to new_session_url
    else
      redirect_to sessions_url
    end
  end

  def require_not_logged_in
    redirect_to cats_url if current_user
  end

  def require_login
    redirect_to new_session_url unless current_user
  end

  protected

  def user_params
    params.require(:user).permit(:username, :password)
  end
end
