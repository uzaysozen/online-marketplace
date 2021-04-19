# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    if user.present?
      if user.administrator?
        can :manage, :all
      else
        # Listing Restrictions
        can :create, Listing
        can :read, Listing, listing_status: {name: 'Active'}
        can [:show, :update, :delete], Listing, creator_id: user.id

        # Listing Category
        can :read, ListingCategory

        # Listing Condition
        can :read, ListingCondition

        # Listing Delivery
        can :read, ListingDelivery

        # Conversation
        can :create, Conversation
        cannot :create, Conversation, listing: {creator_id: user.id}

        can :delete, Conversation, listing: {creator_id: user.id}
        can :delete, Conversation, participant_id: user.id

        # Favourites
        can :create, UserFavourite
        cannot :create, UserFavourite, listing: {creator_id: user.id}
      end
    end
    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
  end
end
