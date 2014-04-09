class Ability
  include CanCan::Ability

  def initialize(user)

    user ||= User.new
    
    can :manage, :all if user.admin 
    
    initialize_pool(user)
    
    can :edit, Pick do |pick|
      (can?(:pick, pick.pool) and pick.user == user) or (pick.pool.admins.include? user and can :view, pick)
    end

    can :view, Pick do |pick|
      can?(:read, pick.pool) and (pick.pool.tournament.locked or user.picks.include? pick)
    end
    
    can :be_invited, User do |u|
      not u.password_hash.nil?
    end
    
    can :accept, NonmemberInvitee do |nmi|
      nmi.user == user and nmi.pool.tournament.locked = false
    end
    
    can :preview, Pick do |pick|
      user.picks.include? pick
    end
    
    can :edit, User do |u|
      u == user
    end
    
  end


  
  def initialize_pool(user)

    can :view_user_picks, PoolMembership do |pm|
      (pm.pool.published? and pm.pool.tournament.locked) or pm.user == user
    end

    can :manage, Pool do |pool|
      pool.admins.include? user
    end
    
    can :read, Pool do |pool|
      (pool.published and (not pool.private or user.all_pools.include?(pool))) or can? :manage, pool
    end
    
    can :read_others, Pool do |pool|
      (can? :read, pool and (pool.published or user.pools.include? pool)) or can? :manage, pool
    end

    can :join, Pool do |pool|
      not user.pools.include? pool and can? :read, pool and not pool.tournament.locked
    end

    can :leave, Pool do |pool|
      not user.id.nil? and user.pools.include? pool
    end
    
    can :publish, Pool do |pool|
      can?(:manage, pool)
    end
    
    can :invite, Pool do |pool|
      pool.published and pool.nonadmin_invite and user.pools.include? pool and not pool.tournament.locked
    end
    
    can :pick, Pool do |pool|
      user.pools.include? pool and (not pool.tournament.locked or pool.admins.include? user)
    end
    
    can :create, Pool do |pool|
      not user.id.nil? and user.admin
    end

    
    # These are to prevent admin from performing illegal actions
    cannot :leave, Pool do |pool|
      not user.pools.include? pool or not pool.published or (pool.admins.include? user and pool.admins.length == 1)
    end
    
    cannot :join, Pool do |pool|
      user.pools.include? pool or not pool.published
    end
    
    #cannot :pick, Pool do |pool|
    #  not pool.published or not can? :read, pool or not user.pools.include?(pool)
    #end
    
    cannot :invite, Pool do |pool|
      not pool.published
    end
      
  end
end
