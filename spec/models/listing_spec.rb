# == Schema Information
#
# Table name: listings
#
#  id                   :bigint           not null, primary key
#  description          :text
#  discounted_price     :decimal(, )
#  is_active            :boolean
#  is_moderated         :boolean
#  location             :string(50)
#  price                :decimal(, )      default(0.0)
#  swap                 :boolean
#  title                :string(50)
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  creator_id           :bigint
#  listing_category_id  :bigint
#  listing_condition_id :bigint
#  listing_status_id    :bigint
#  moderator_id         :bigint
#  receiver_id          :bigint
#
# Indexes
#
#  index_listings_on_creator_id            (creator_id)
#  index_listings_on_listing_category_id   (listing_category_id)
#  index_listings_on_listing_condition_id  (listing_condition_id)
#  index_listings_on_listing_status_id     (listing_status_id)
#  index_listings_on_moderator_id          (moderator_id)
#  index_listings_on_receiver_id           (receiver_id)
#
# Foreign Keys
#
#  fk_rails_...  (creator_id => users.id)
#  fk_rails_...  (listing_category_id => listing_categories.id)
#  fk_rails_...  (listing_condition_id => listing_conditions.id)
#  fk_rails_...  (listing_status_id => listing_statuses.id)
#  fk_rails_...  (moderator_id => users.id)
#  fk_rails_...  (receiver_id => users.id)
#
require 'rails_helper'

RSpec.describe Listing, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
