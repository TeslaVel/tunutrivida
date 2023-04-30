# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    can :manage, Gender if (user.has_role?(:dietitian) || user.has_role?(:super_admin))
    can :manage, Discount if (user.has_role?(:dietitian) || user.has_role?(:super_admin))
    can :manage, Product if (user.has_role?(:dietitian) || user.has_role?(:super_admin))
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
  end
end
