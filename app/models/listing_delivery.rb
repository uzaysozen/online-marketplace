# == Schema Information
#
# Table name: listing_deliveries
#
#  id          :bigint           not null, primary key
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  delivery_id :bigint
#  listing_id  :bigint
#
# Indexes
#
#  index_listing_deliveries_on_delivery_id  (delivery_id)
#  index_listing_deliveries_on_listing_id   (listing_id)
#
# Foreign Keys
#
#  fk_rails_...  (delivery_id => deliveries.id)
#  fk_rails_...  (listing_id => listings.id)
#
class ListingDelivery < ApplicationRecord
    belongs_to :listing
    belongs_to :delivery
end
