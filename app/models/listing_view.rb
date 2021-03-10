# == Schema Information
#
# Table name: listing_views
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  listing_id :bigint
#  user_id    :bigint
#
class ListingView < ApplicationRecord
    belongs_to :user
    belongs_to :listing
end
