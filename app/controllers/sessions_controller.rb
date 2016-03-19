class SessionsController < ApplicationController
  layout 'home'
  before_action :confirm_not_logged_in, except: [:destroy]

  def new
  end

  def create
    # if params[:login_id].present? used at the end of the lines, because we would like to
    # show "Incorrect Email or Username" error if user did not write anything for login_id.

    logged_in_with_email = User.find_by_email(params[:login_id]) if params[:login_id].present?
    logged_in_with_username = User.find_by_username(params[:login_id]) if params[:login_id].present?

    if logged_in_with_email
      if logged_in_with_email.password_match?(params[:password])
        if params[:remember_me]
          cookies.permanent[:authorization_token] = logged_in_with_email.authorization_token
        else
          cookies[:authorization_token] = logged_in_with_email.authorization_token
        end
        redirect_to dashboard_path
      else
        flash[:title] = 'Incorrect Password'
        flash[:description] = 'The password you entered is incorrect. <u>Please make sure your caps lock is off</u>.'
        redirect_to login_path
      end
    elsif logged_in_with_username
      if logged_in_with_username.password_match?(params[:password])
        if params[:remember_me]
          cookies.permanent[:authorization_token] = logged_in_with_username.authorization_token
        else
          cookies[:authorization_token] = logged_in_with_username.authorization_token
        end
        redirect_to dashboard_path
      else
        flash[:title] = 'Incorrect Password'
        flash[:description] = 'The password you entered is incorrect. <u>Please make sure your caps lock is off</u>.'
        redirect_to login_path
      end
    else
      flash[:title] = 'Incorrect Email or Username'
      flash[:description] = 'The email or username you entered does not belong to any account. <u>Please make sure you typed correctly</u>.'
      redirect_to login_path
    end
  end

  def destroy
    cookies.delete(:authorization_token)
    redirect_to root_path
  end
end
