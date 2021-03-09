# == Schema Information
#
# Table name: user_favourites
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  listing_id :bigint
#  user_id    :bigint
#
FactoryBot.define do
  factory :user_favourite do
    
  end
end
