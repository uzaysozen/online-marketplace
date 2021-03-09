# == Schema Information
#
# Table name: listing_statuses
#
#  id         :bigint           not null, primary key
#  name       :string(50)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require 'rails_helper'

RSpec.describe ListingStatus, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
