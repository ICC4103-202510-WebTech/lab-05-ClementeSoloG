class Ability
  include CanCan::Ability

  def initialize(user)
    return unless user.present?

    can :read, :all
    can :create, Message
    can :create, Chat
    can [:update, :destroy], Message, user_id: user.id
    can [:update, :destroy], User, id: user.id


    can [:update, :destroy], Message do |message|
      chat = message.chat
      chat && (chat.sender_id == user.id || chat.receiver_id == user.id)
    end
  end
end
