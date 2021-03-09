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
#  price                :decimal(, )
#  title                :string(50)
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  category_id          :bigint
#  creator_id           :bigint
#  listing_condition_id :bigint
#  listing_status_id    :bigint
#  moderator_id         :bigint
#  receiver_id          :bigint
#
require 'rails_helper'

RSpec.describe Listing, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
