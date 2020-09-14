class SessionsController < ApplicationController
  before_action :already_signed_in, only: :new

  def new
    @user = User.new
    render :new
  end

  def create
    user = User.find_by_credentials(
      params[:user][:username],
      params[:user][:password])

    if user
        login_user(user)
        redirect_to cats_url
    else
      flash[:errors] ||= []
      flash[:errors] << 'Invalid credentials'
      redirect_to new_sessions_url
    end
  end

  def destroy
    Session.find_by(session_token: current_user.session_token).destroy
    current_user.try(:reset_session_token!)
    session[:session_token] = nil
    redirect_to cats_url
  end

  
end