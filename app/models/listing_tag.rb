# == Schema Information
#
# Table name: listing_tags
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  listing_id :bigint
#  tag_id     :bigint
#
class ListingTag < ApplicationRecord
    belongs_to :listings
    belongs_to :tags
end
