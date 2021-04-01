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
require 'rails_helper'

RSpec.describe ListingDelivery, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
