class ApplicationController < ActionController::Base
  rescue_from ActiveRecord::RecordNotFound, :with => :record_not_found

  protect_from_forgery with: :exception

  helper_method :current_user, :received_messages

  def current_user
    @user ||= User.find_by_authorization_token!(cookies[:authorization_token]) if cookies[:authorization_token]
  end

  # This helper method is used to display notification badge on message button in the header
  def received_messages
    @number_of_messages = Message.all_unread_messages(current_user.id).length
  end

  private
  def confirm_logged_in
    unless cookies[:authorization_token]
      flash[:title] = 'Access Restricted'
      flash[:description] = 'Please log into your account or sign up to proceed.'
      redirect_to login_path
    end
  end

  private
  def confirm_not_logged_in
    if cookies[:authorization_token]
      redirect_to dashboard_path
    end
  end

  # TODO: Un-comment this as well.
  # def record_not_found
  #   render 'errors/record_not_found'
  # end
end
