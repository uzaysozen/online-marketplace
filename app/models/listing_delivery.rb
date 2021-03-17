# == Schema Information
#
# Table name: listing_deliveries
#
#  id         :bigint           not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class ListingDelivery < ApplicationRecord
    has_many :listings
end
