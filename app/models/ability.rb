class Ability
  include CanCan::Ability

   def initializer(user)
      user ||= User.new

      if user.role == 'admin'
        can :manage, :all
      else
        can :manage, Post, author_id: user_id
        can :manage, Comment, author_id: user_id
        can :read, :all
      end
  end
end
