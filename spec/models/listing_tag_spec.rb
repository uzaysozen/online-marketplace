# == Schema Information
#
# Table name: listing_tags
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  listing_id :bigint
#  tag_id     :bigint
#
require 'rails_helper'

RSpec.describe ListingTag, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
