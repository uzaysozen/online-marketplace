# == Schema Information
#
# Table name: listing_conditions
#
#  id         :bigint           not null, primary key
#  name       :string(50)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require 'rails_helper'

RSpec.describe ListingCondition, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
