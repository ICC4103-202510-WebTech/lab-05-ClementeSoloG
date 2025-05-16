class MessagesController < ApplicationController
    before_action :set_message, only: [ :edit, :show, :update, :destroy]
    before_action :set_chats_and_users, only: [:new, :create, :edit, :update]

    def index
        @messages = Message.all
    end

    def show
    end
    
    def new
        @message = Message.new
    end
    
    def create
        @message = Message.new(message_params)
        if @message.save
          flash[:notice] = "Succesfully saved"
          redirect_to message_path(@message), notice: 'Message was successfully created.'
        else
          flash[:alert] = "#{@message.errors.full_messages.join(", ")}"
          redirect_to new_message_path
        end
    end

    def edit
    end

    def update
        if @message.update message_params
            redirect_to message_path(@message)
        else
            redirect_to edit_message_path(@message)
        end
    end
    
    def destroy
        @message.destroy
        redirect_to messages_path
    end
    
      private
    
    def message_params
        params.require(:message).permit(:chat_id, :user_id, :body)
    end

    def set_message
      @message = Message.find(params["id"])
    end

    def set_chats_and_users
      @chats = Chat.all
      @users = User.all
    end
end 