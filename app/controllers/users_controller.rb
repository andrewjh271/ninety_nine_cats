class UsersController < ApplicationController
  before_action :already_signed_in, only: :new

  def new
    @user = User.new
    render :new

  end

  def create
    @user = User.new(user_params)
    if @user.save
      # msg = UserMailer.welcome_email(@user)
      # msg.deliver_now
      # Not used for Heroku app — no real mail setup exists

      login_user(@user)
      redirect_to cats_url
    else
      flash.now[:errors] = @user.errors.full_messages
      render :new
    end
  end

  def show
    render :show
  end

  private

  def user_params
    params.require(:user).permit(:username, :password)
  end

end