class ChatsController < ApplicationController
    before_action :set_chat, only: [ :edit, :show, :update, :destroy]
    before_action :set_users, only: [:new, :create, :edit, :update]
    def index
        @chats = Chat.all
    end
    def show
    end 

    def new
        @chat = Chat.new
    end
    
    def create
        @chat = Chat.new(chat_params)
        if @chat.save
            flash[:notice] = "Succesfully saved"
            redirect_to chat_path(@chat), notice: 'Chat was successfully created.'
        else
            flash[:alert] = "#{@chat.errors.full_messages.join(", ")}"
            redirect_to new_chat_path
        end
    end

    def edit
    end

    def update
        if @chat.update chat_params
            redirect_to chat_path(@chat)
        else
            redirect_to edit_message_path(@chat)
        end
    end
    
    def destroy
        @chat.destroy
        redirect_to chat_path
    end

    private
    
    def chat_params
        params.require(:chat).permit(:sender_id, :receiver_id)
    end

    def set_chat
      @chat = Chat.find(params["id"])
    end 

    def set_users
      @users = User.all
    end
end 