class MessagesController < ApplicationController
  before_action :set_conversation

  def index
    @messages = @conversation.messages
    if @messages.length > 10
      @over_ten = true
      @messages = @messages[-10..]
    end
    if params[:m]
      @over_ten = false
      @messages = @conversation.messages
    end
    @messages.last.read = true if @messages.last && @messages.last.user_id != current_user.id
    @message = @conversation.messages.new
  end

  def create
    @message = @conversation.messages.new(body: params[:message][:body], user_id: current_user.id)
    return unless @message.save

    ActionCable.server.broadcast 'message_channel', { message: @message.body, user_id: @message.user_id, created_at: @message.created_at }


    redirect_to conversation_messages_path(@conversation)
  end

  private

  def set_conversation
    @conversation = Conversation.find(params[:conversation_id])
  end
end
