# == Schema Information
#
# Table name: listing_images
#
#  id         :bigint           not null, primary key
#  image_path :string(50)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class ListingImage < ApplicationRecord
    belongs_to :listing
end
