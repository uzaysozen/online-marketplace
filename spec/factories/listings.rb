# == Schema Information
#
# Table name: listings
#
#  id                   :bigint           not null, primary key
#  description          :text
#  discounted_price     :decimal(, )
#  location             :string(50)
#  price                :decimal(, )
#  swap                 :boolean
#  title                :string(50)
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  creator_id           :bigint
#  listing_category_id  :bigint
#  listing_condition_id :bigint
#  listing_status_id    :bigint
#  receiver_id          :bigint
#
# Indexes
#
#  index_listings_on_creator_id            (creator_id)
#  index_listings_on_listing_category_id   (listing_category_id)
#  index_listings_on_listing_condition_id  (listing_condition_id)
#  index_listings_on_listing_status_id     (listing_status_id)
#  index_listings_on_receiver_id           (receiver_id)
#
# Foreign Keys
#
#  fk_rails_...  (creator_id => users.id)
#  fk_rails_...  (listing_category_id => listing_categories.id)
#  fk_rails_...  (listing_condition_id => listing_conditions.id)
#  fk_rails_...  (listing_status_id => listing_statuses.id)
#  fk_rails_...  (receiver_id => users.id)
#
FactoryBot.define do
  factory :listing do
    creator
    listing_category
    listing_status
    listing_condition
    moderator
    receiver
    title { "Some Listing" }
    price { 12.34 }
    description { "A description for a listing" }
    location { "Sheffield" }
    swap { false }
  end
end
