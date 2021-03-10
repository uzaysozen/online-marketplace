# == Schema Information
#
# Table name: reports
#
#  id                      :bigint           not null, primary key
#  message                 :text
#  outcome                 :text
#  created_at              :datetime         not null
#  updated_at              :datetime         not null
#  conversation_message_id :bigint
#  listing_id              :bigint
#  moderator_id            :bigint
#  user_id                 :bigint
#
FactoryBot.define do
  factory :report do
    
  end
end
