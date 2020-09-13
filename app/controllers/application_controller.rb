class ApplicationController < ActionController::Base
  helper_method :current_user

  def login_user(user)
    user.reset_session_token!
    session[:session_token] = user.session_token
  end

  def current_user
    return nil unless session[:session_token]

    @current_user ||= User.find_by(session_token: session[:session_token])
  end

  def already_signed_in
    redirect_to cats_url if current_user
  end
end
