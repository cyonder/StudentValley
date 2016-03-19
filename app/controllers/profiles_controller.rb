class ProfilesController < ApplicationController
  before_action :confirm_logged_in

  def show
    found_user = User.find_by_id(params[:id])

    if found_user
      @profile = found_user
      @friendship = Friendship.find_by_user_id_and_friend_id(current_user.id, @profile.id)
    else
      # render 'errors/profile_not_found'
    end
  end

  def edit
    @profile = User.find_by_id(current_user.id)
  end

  def update
    @profile = User.find_by_id(current_user.id)

    case params[:attribute]
      when 'profile'
        if @profile.update_attributes(profile_parameters)
          flash[:notice] = 'Your profile information has been updated successfully'
          redirect_to request.referrer
        else
          render 'edit'
        end
      when 'photo'
        if params[:button] == 'upload'
          if @profile.update_attributes(photo_parameter)
            flash[:notice] = 'Your profile photo has been updated successfully'
            redirect_to request.referer
          else
            @profile.errors.delete(:photo) # Necessary to prevent duplicate error messages caused by Paperclip
            render 'edit'
          end
        elsif params[:button] == 'delete'
          @profile.photo = nil
          @profile.save
          flash[:notice] = 'Your profile photo has been deleted successfully'
          redirect_to request.referer
        else
          render 'edit'
        end
      when 'username'
        if @profile.update_attributes(username_parameter)
          flash[:notice] = 'Your username has been changed successfully'
          redirect_to request.referrer
        else
          render 'edit'
        end
      when 'email'
        if @profile.update_attributes(email_parameter)
          flash[:notice] = 'Your email has been changed successfully'
          redirect_to request.referrer
        else
          render 'edit'
        end
      when 'password'
        if @profile.change_password(params[:user][:current_password], params[:user][:password], params[:user][:password_confirmation])
          flash[:notice] = 'Your password has been changed successfully'
          redirect_to request.referrer
        else
          render 'edit'
        end
      else
        render 'edit'
    end
  end

  private
  def profile_parameters
    params.require(:user).permit(:first_name, :last_name, :school, :program, :website, :information)
  end

  private
  def username_parameter
    params.require(:user).permit(:username)
  end

  private
  def email_parameter
    params.require(:user).permit(:email)
  end

  private
  def photo_parameter
    params.fetch(:user, {}).permit(:photo)
  end
end