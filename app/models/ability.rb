class Ability
  include CanCan::Ability

  def initialize(user)

    user ||= User.new

    can :manage, :all if user.admin 
    

    can :manage, Pool do |pool|
      user.admin
    end

  end
end
