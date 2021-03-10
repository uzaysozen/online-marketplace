# == Schema Information
#
# Table name: listing_images
#
#  id         :bigint           not null, primary key
#  image_path :string(50)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  listing_id :bigint
#
require 'rails_helper'

RSpec.describe ListingImage, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
