class Ability
  include CanCan::Ability

  def initialize(user)

    user ||= User.new
    
    can :manage, :all if user.admin 
    
    can :read, Pool do |pool|
      pool.published and not pool.private
    end
    
    can :join, Pool do |pool|
      can?(:read, pool) and not user.pools.include? pool
    end
    
    can :invite, Pool do |pool|
      pool.published and pool.nonadmin_invite and user.pools.include? pool
    end
    
    cannot :leave, Pool do |pool|
      not user.pools.include? pool
    end
  end
end