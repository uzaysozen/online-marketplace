# == Schema Information
#
# Table name: listing_questions
#
#  id         :bigint           not null, primary key
#  answer     :string(50)
#  question   :string(50)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  listing_id :bigint
#
FactoryBot.define do
  factory :listing_question do
    
  end
end
