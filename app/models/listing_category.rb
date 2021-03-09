# == Schema Information
#
# Table name: listing_categories
#
#  id         :bigint           not null, primary key
#  name       :string(50)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  parent_id  :bigint
#
class ListingCategory < ApplicationRecord
    has_and_belongs_to_many :listings
end
