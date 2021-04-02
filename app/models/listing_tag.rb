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
# Indexes
#
#  index_listing_tags_on_listing_id  (listing_id)
#  index_listing_tags_on_tag_id      (tag_id)
#
# Foreign Keys
#
#  fk_rails_...  (listing_id => listings.id)
#  fk_rails_...  (tag_id => tags.id)
#
class ListingTag < ApplicationRecord
    belongs_to :listing
    belongs_to :tag
end
