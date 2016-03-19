class FriendshipsController < ApplicationController
  before_filter :setup_friends

  def connect
    Friendship.send_request(@user, @friend)
    redirect_to request.referrer
  end

  def accept
    if @user.requested_friends.include?(@friend)
      Friendship.accept_request(@user, @friend)
    end
    redirect_to request.referrer
  end

  def cancel
    if @user.pending_friends.include?(@friend)
      Friendship.breakup(@user, @friend)
    end
    redirect_to request.referrer
  end

  def decline
    if @user.requested_friends.include?(@friend)
      Friendship.breakup(@user, @friend)
    end
    redirect_to request.referrer
  end

  def disconnect
    if @user.friends.include?(@friend)
      Friendship.breakup(@user, @friend)
    end
    redirect_to request.referrer
  end

  private
  def setup_friends
    @user = User.find(current_user.id)
    @friend = User.find(params[:id])
  end
end