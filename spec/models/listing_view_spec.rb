# == Schema Information
#
# Table name: listing_views
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  listing_id :bigint
#  user_id    :bigint
#
require 'rails_helper'

RSpec.describe ListingView, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
