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
class UserFavourite < ApplicationRecord
    belongs_to :user
    belongs_to :listing
end
