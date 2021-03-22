# == Schema Information
#
# Table name: listing_deliveries
#
#  id          :bigint           not null, primary key
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  delivery_id :bigint
#  listing_id  :bigint
#
FactoryBot.define do
  factory :listing_delivery do
    name { "MyString" }
  end
end
