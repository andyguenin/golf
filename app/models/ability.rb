class Ability
  include CanCan::Ability

  def initialize(user)

    user ||= User.new

    can :manage, :all if user.admin 
    
    can :manage, Group do |group|
      group.admins.include?(user)
    end

    can :manage, Pool do |pool|
      can? :manage, pool.group
    end

    can :read, Group do |group|
      group.users.include? user
    end

    can :read, Pool do |pool|
      can? :read, pool.group
    end

  end
end
