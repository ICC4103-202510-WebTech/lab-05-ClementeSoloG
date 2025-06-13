class ChatsController < ApplicationController
  before_action :authenticate_user!
  load_and_authorize_resource

  before_action :set_users, only: [:new, :create, :edit, :update]

  def index
    # load_and_authorize_resource ya define @chats
    # pero si quieres limitar solo a los chats del usuario actual:
    @chats = Chat.where("sender_id = ? OR receiver_id = ?", current_user.id, current_user.id)
  end

  def show
    # @chat ya está cargado por load_and_authorize_resource
  end

  def new
    # @chat ya está inicializado por load_and_authorize_resource
  end

  def create
    @chat.sender = current_user

    if @chat.save
      redirect_to chat_path(@chat), notice: 'Chat was successfully created.'
    else
      flash[:alert] = @chat.errors.full_messages.join(", ")
      render :new
    end
  end

  def edit
  end

  def update
    if @chat.update(chat_params)
      redirect_to chat_path(@chat)
    else
      flash[:alert] = @chat.errors.full_messages.join(", ")
      render :edit
    end
  end

  def destroy
    @chat.destroy
    redirect_to chats_path, notice: 'Chat was successfully deleted.'
  end

  private

  def chat_params
    params.require(:chat).permit(:receiver_id)
  end

  def set_users
    @users = User.where.not(id: current_user.id)
  end
end
