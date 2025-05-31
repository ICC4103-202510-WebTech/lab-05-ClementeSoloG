
class Ability
  include CanCan::Ability

  def initialize(dev) 
    can :manage, Chat, dev: dev
    can :manage, Message, dev: dev
    can :manage, User, dev: dev
    dev ||= Dev.new 
    if dev.admin?
      can :manage, :all 
    else
      can :read, :all
      can :create, Message 

      can [:update, :destroy], Message, dev_id: dev.id
    end
  end
end