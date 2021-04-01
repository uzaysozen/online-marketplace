# == Schema Information
#
# Table name: deliveries
#
#  id         :bigint           not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Delivery < ApplicationRecord
    has_many :listing_deliveries
    has_many :listings, through: :listing_deliveries
end
