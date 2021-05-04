# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    if user.present?
      if user.administrator?
        # TODO: Whilst this will always work fine, may be worth refactoring to be explicit
        can :manage, :all
      else
        # Listing Restrictions
        can :create, Listing
        can :read, Listing, listing_status: { name: 'Active' }
        can [:show, :update, :delete], Listing, creator_id: user.id

        # Listing Category
        can :read, ListingCategory

        # Listing Condition
        can :read, ListingCondition

        # Listing Delivery
        can :read, ListingDelivery

        # Conversation
        can :create, Conversation

        can :delete, Conversation, listing: { creator_id: user.id }
        can :delete, Conversation, participant_id: user.id

        # Favourites
        can :create, UserFavourite
      end

      # Declare restrictions that will always apply, such as not
      # starting a conversation with yourself.
      cannot :create, Conversation, listing: { creator_id: user.id }
      cannot :create, UserFavourite, listing: { creator_id: user.id }
      cannot :create, Report, listing: { creator_id: user.id }

      cannot :list, Listing
      can :list, Listing, listing_status: { name: "Active" }
    end
  end
end
