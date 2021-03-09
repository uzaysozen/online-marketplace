# == Schema Information
#
# Table name: conversations
#
#  id             :bigint           not null, primary key
#  created_at     :datetime         not null
#  updated_at     :datetime         not null
#  listing_id     :bigint
#  participant_id :bigint
#
class Conversation < ApplicationRecord
    belongs_to :listing
    belongs_to :participant , class_name: "User"
end
