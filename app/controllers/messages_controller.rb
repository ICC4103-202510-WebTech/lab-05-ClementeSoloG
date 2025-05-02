class MessagesController < ApplicationController
    def index
        @messages = Message.all
    end
    def show
        @messages = Message.find(params["id"])
    end
    def new
        @message = Message.new
        @chats = Chat.all
        @users = User.all
    end
    
    def create
        @message = Message.new(message_params)
        if @message.save
          redirect_to message_path(@message), notice: 'Message was successfully created.'
        else
          render :new
        end
    end
    
      private
    
    def message_params
        params.require(:message).permit(:chat_id, :user_id, :body)
    end
end 