# == Schema Information
#
# Table name: user_favourites
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  listing_id :bigint
#  user_id    :bigint
#
# Indexes
#
#  index_user_favourites_on_listing_id  (listing_id)
#  index_user_favourites_on_user_id     (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (listing_id => listings.id)
#  fk_rails_...  (user_id => users.id)
#
require 'rails_helper'

RSpec.describe UserFavourite, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
