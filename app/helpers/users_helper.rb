module UsersHelper
  def user_error_messages_for(object)
    render partial: 'users/new_error_messages', locals: {object: object}
  end
end
