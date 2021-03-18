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
class ListingDelivery < ApplicationRecord
    belongs_to :listings
    belongs_to :deliveries
end
