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
# Indexes
#
#  index_listing_views_on_listing_id  (listing_id)
#  index_listing_views_on_user_id     (user_id)
#
FactoryBot.define do
  factory :listing_view do
    
  end
end
