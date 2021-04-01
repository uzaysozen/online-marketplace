# == Schema Information
#
# Table name: listing_ratings
#
#  id            :bigint           not null, primary key
#  buyer_rating  :integer
#  seller_rating :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  listing_id    :bigint
#
# Indexes
#
#  index_listing_ratings_on_listing_id  (listing_id)
#
# Foreign Keys
#
#  fk_rails_...  (listing_id => listings.id)
#
class ListingRating < ApplicationRecord
    belongs_to :listing
end
