class MessagesController < ApplicationController
  before_action :confirm_logged_in

  before_action do
    @conversations = Message.find_by_sql(conversations_query)
    @last_conversation = @conversations.first.correspondent
  end

  def index
    redirect_to messages_path(@last_conversation) unless params[:id]

    if params[:id]
      # && @conversations.include?(params[:id]) TODO: I was doing something important but didn't work! WTF was that?
      @messages = Message.all_messages(params[:id], current_user.id)
      Message.where('recipient_id = ? AND sender_id = ?', current_user.id, params[:id]).update_all(read: true)
    end
  end

  def new
    @message = Message.new
  end

  def create
    @message = Message.new
    @message.sender_id = current_user.id
    @message.recipient_id = params[:id]
    @message.message = params[:message][:message].strip

    @message.save # TODO: Put if statement. If doesn't save, redirect.
    redirect_to messages_path(params[:id])
  end

  def destroy

  end

  private
  def conversations_query
    "SELECT correspondent, MAX(updated_at) as date FROM
    (SELECT sender_id as correspondent,updated_at FROM messages WHERE recipient_id = #{current_user.id}
    UNION ALL SELECT recipient_id as correspondent, updated_at FROM messages WHERE sender_id = #{current_user.id})
    x GROUP BY correspondent ORDER BY date desc"
  end
end

