class Ability
  include CanCan::Ability

  def initialize(user)

    user ||= User.new
    user.role = 0
    can :manage, :all if user.role == ADMIN
    
    can :update, Group do |group|
      user.role >= MODERATOR && group.admin.include?(user)
    end

    can :create, Group if user.role >= MODERATOR

    can :view, Group do |group|
      group.users.include? user
    end

    can :view, Pool do |pool|
      pool.group.users.include? user
    end
  end
end
