# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    
    can :manage , Gender if user.has_role? :dietitian
    can :manage , Discount if user.has_role? :dietitian
    can :manage , Product if user.has_role? :dietitian
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
  end
end
