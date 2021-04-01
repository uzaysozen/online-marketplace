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
require 'rails_helper'

RSpec.describe ListingRating, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
