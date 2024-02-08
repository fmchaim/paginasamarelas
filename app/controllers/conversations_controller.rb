class ConversationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @users = User.all
    @conversations = Conversation.all

    if Conversation.find_by(sender_id: params[:sender_id], recipient_id: params[:recipient_id]).present?
      @conversation = Conversation.find_by(sender_id: params[:sender_id], recipient_id: params[:recipient_id])
      redirect_to conversation_messages_path(@conversation)
    else
     if params[:recipient_id].to_i != current_user.id
        @conversation = Conversation.create(sender_id: params[:sender_id], recipient_id: params[:recipient_id])
        redirect_to conversation_messages_path(@conversation)
    end
  end
  end

  private

  def conversation_params
    params.require(:conversation).permit(:sender_id, :recipient_id)
  end
end
