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
class Report < ApplicationRecord
    belongs_to :user
    belongs_to :moderator, class_name: "User"
    belongs_to :listing
    belongs_to :conversation_message
end
