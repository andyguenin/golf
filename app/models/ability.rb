class Ability
  include CanCan::Ability

  def initialize(user)

    user ||= User.new
    
    can :manage, :all if user.admin 
    
    initialize_pool(user)
    
    
  end
  
  def initialize_pool(user)
    
    can :read_summary, Pool do |pool|
      pool.published and (not pool.private? or user.all_pools.include?(pool))
    end
    
    can :read, Pool do |pool|
      pool.published and (not pool.private or user.pools.include?(pool)) and pool.tournament.locked
    end
    
    can :join, Pool do |pool|
      can? :read_summary, pool
    end
    
    can :publish, Pool do |pool|
      can?(:manage, pool)
    end
    
    can :invite, Pool do |pool|
      pool.published and pool.nonadmin_invite and user.pools.include? pool
    end
    
    can :see, Pool do |pool|
      can?(:read, pool) or can?(:join, pool)
    end
    
    
    # These are to prevent admin from performing illegal actions
    cannot :leave, Pool do |pool|
      not user.pools.include? pool
    end
    
    cannot :join, Pool do |pool|
      user.pools.include? pool
    end
  end
end