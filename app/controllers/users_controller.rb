class UsersController < ApplicationController
  layout 'home'
  before_action :confirm_not_logged_in

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      cookies[:authorization_token] = @user.authorization_token
      redirect_to dashboard_path
    else
      render('new')
    end
  end

  def edit
  end

  def update
  end

  private
  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :email_confirmation, :password)
  end
end
