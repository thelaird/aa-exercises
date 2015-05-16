class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :logged_in?, :current_user, :authenticity

  def current_user
    User.find_by(session_token: session[:session_token])
  end

  def logged_in?
    !!current_user
  end

  def log_in_user!(user)
    session[:session_token] = user.reset_session_token!
  end

  def log_out_user!(user)
    user.reset_session_token!
    session[:session_token] = nil
  end

  def authenticity
    html = <<-RUBY
      <input type='hidden'
        name='authenticity_token'
        value="#{form_authenticity_token}">
      RUBY
    html.html_safe
  end

  protected

  def user_params
    params.require(:user).permit(:username, :password)
  end
end
