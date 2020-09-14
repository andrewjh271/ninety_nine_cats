class ApplicationController < ActionController::Base
  helper_method :current_user

  def login_user(user)
    user.reset_session_token!
    session[:session_token] = user.session_token

    browser = Browser.new(request.env['HTTP_USER_AGENT'], accept_language: "en-us")
    Session.create!(session_token: user.session_token,
                    user_id: user.id,
                    browser_name: browser.name,
                    platform_name: browser.platform.name,
                    platform_version: browser.platform.version)
  end

  def current_user
    return nil unless session[:session_token]

    # @current_user ||= User.find_by(session_token: session[:session_token])
    @current_user ||= Session.find_by(session_token: session[:session_token]).try(:user)
  end

  def already_signed_in
    redirect_to cats_url if current_user
  end

  def require_current_user
    redirect_to new_sessions_url unless current_user
  end

  def user_must_own_cat
    @cat = current_user.cats.find_by(id: params[:id])
    redirect_to cats_url unless @cat
  end
end
