module ProfilesHelper

  # ---------------------------------------------------------------------------- #
  # -- Display Profile Buttons Logic ------------------------------------------- #
  # ---------------------------------------------------------------------------- #
  # The purpose of this helper is to display connection buttons in profile page,
  # right above 'about' section. According to current profile's friendship with
  # current_user, this helper will display proper connection button. Besides,
  # if current_user is in his/her own profile, buttons will not show up.
  #
  # Disconnect button is rendered differently, because it will pop-up bootstrap
  # modal. That's why it is little bit different/
  # ---------------------------------------------------------------------------- #

  def display_profile_buttons
    if @profile.id == current_user.id
      # This is current user's profile, that's why do not display buttons.
    else
      if @friendship.present? # Checking if @friendship has returned nil from profile controller.
        if @friendship.status == 'pending'
          render 'profiles/profile_buttons', locals: {button: 'cancel', path: cancel_path(@profile.id)}
        elsif @friendship.status == 'requested'
          render 'profiles/profile_buttons', locals: {button: 'accept', path: accept_path(@profile.id)}
        elsif @friendship.status == 'accepted'
          render 'profiles/profile_buttons', locals: {button: 'disconnect', path: disconnect_path(@profile.id)}
        else
          render 'profiles/profile_buttons', locals: {button: 'connect', path: connect_path(@profile.id)}
        end
      else
        render 'profiles/profile_buttons', locals: {button: 'connect', path: connect_path(@profile.id)}
      end
    end
  end

  # ---------------------------------------------------------------------------- #
  # -- Display Connections Buttons Logic --------------------------------------- #
  # ---------------------------------------------------------------------------- #
  # The purpose of this helper is to display connection buttons in connections
  # page, right next to connection's name. According to current profile's
  # friendship with current_user, this helper will display proper connection
  # button. Besides, if current_user sees his/her own name, in someone's
  # connections list buttons will not show up.
  # ---------------------------------------------------------------------------- #

  def display_connections_buttons(friend)
    if current_user.friends.include?(friend)
      render 'profiles/connections/connections_buttons', locals: {button: 'dropdown', path: disconnect_path(friend.id), modal_id: friend.id}
    elsif current_user.pending_friends.include?(friend)
      render 'profiles/connections/connections_buttons', locals: {text: 'Cancel', path: cancel_path(friend.id), color: 'btn-info'}
    elsif current_user.requested_friends.include?(friend)
      render 'profiles/connections/connections_buttons', locals: {text: 'Accept', path: accept_path(friend.id), color: 'btn-success'}
    else
      # Don't show any connection button to user itself.
      unless current_user.id == friend.id
        render 'profiles/connections/connections_buttons', locals: {text: 'Connect', path: connect_path(friend.id), color: 'btn-primary'}
      end
    end
  end

  # ---------------------------------------------------------------------------- #
  # -- Display Profile Content Logic ------------------------------------------- #
  # ---------------------------------------------------------------------------- #
  # The purpose of this helper is to display related content on the right side of
  # left profile layout.
  # ---------------------------------------------------------------------------- #

  def display_profile_content
    if current_path?(connections_path)
      render 'profiles/connections/connections'
    elsif current_path?(received_requests_path)
      render 'profiles/connections/received_requests'
    elsif current_path?(sent_requests_path)
      render 'profiles/connections/sent_requests'
    else
      render 'profiles/main'
    end
  end

  # ---------------------------------------------------------------------------- #
  # -- Display Settings Content Logic ------------------------------------------ #
  # ---------------------------------------------------------------------------- #
  # The purpose of this helper is to display related content on the right side of
  # left settings layout.
  # ---------------------------------------------------------------------------- #

  def display_settings_content
    if current_path?(password_settings_path)
      render 'profiles/settings/password'
    elsif current_path?(account_settings_path)
      render 'profiles/settings/account'
    else
      render 'profiles/settings/profile'
    end
  end

  def settings_error_messages_for(object)
    render partial: 'profiles/settings/new_error_messages', locals: {object: object}
  end
end
