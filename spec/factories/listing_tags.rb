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
FactoryBot.define do
  factory :listing_tag do
    
  end
end
