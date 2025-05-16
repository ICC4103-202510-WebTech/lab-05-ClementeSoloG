class User < ApplicationRecord
  has_many :messages, foreign_key: "user_id"

  has_many :chats_as_sender, class_name: "Chat", foreign_key: "sender_id"
  has_many :chats_as_receiver, class_name: "Chat", foreign_key: "receiver_id"

  def chats
    Chat.where("sender_id = ? OR receiver_id = ?", id, id)
  end

  validates :email, presence: true, uniqueness: true
end
