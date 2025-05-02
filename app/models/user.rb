class User < ApplicationRecord

    has_many :sent_messages, class_name: "Message", foreign_key: "user_id"
    has_many :chats_as_receiver, class_name: "Chat", foreign_key: "receiver_id"
    has_many :received_messages, through: :chats_as_receiver, source: :messages
    
    validates :email, presence: true, uniqueness: true
end
  