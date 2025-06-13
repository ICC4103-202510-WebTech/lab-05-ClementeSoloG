class MessagesController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource
  before_action :set_chats, only: [:new, :create, :edit, :update]

  def index
    # Ya tienes @messages por load_and_authorize_resource
    @messages = Message.joins(:chat)
                   .where("chats.sender_id = ? OR chats.receiver_id = ?", current_user.id, current_user.id)

  end


  def show
  end

  def new
    # @message ya creado por CanCanCan
  end

  def create
    @message.user = current_user  

    if @message.save
      redirect_to message_path(@message), notice: 'Message was successfully created.'
    else
      flash[:alert] = @message.errors.full_messages.join(", ")
      render :new
    end
  end

  def edit
  end

  def update
    if @message.update(message_params)
      redirect_to message_path(@message)
    else
      flash[:alert] = @message.errors.full_messages.join(", ")
      render :edit
    end
  end

  def destroy
    @message.destroy
    redirect_to messages_path, notice: "Message deleted."
  end

  private

  def message_params
    # user_id ya no se permite aquí
    params.require(:message).permit(:chat_id, :body)
  end

  def set_chats
    # Para usar en el formulario como selector
    @chats = Chat.where("sender_id = ? OR receiver_id = ?", current_user.id, current_user.id)
  end
end
