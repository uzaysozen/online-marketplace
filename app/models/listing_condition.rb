# == Schema Information
#
# Table name: listing_conditions
#
#  id         :bigint           not null, primary key
#  name       :string(50)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class ListingCondition < ApplicationRecord
end
