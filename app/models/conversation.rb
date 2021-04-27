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
# Indexes
#
#  index_conversations_on_listing_id      (listing_id)
#  index_conversations_on_participant_id  (participant_id)
#
# Foreign Keys
#
#  fk_rails_...  (listing_id => listings.id)
#  fk_rails_...  (participant_id => users.id)
#
class Conversation < ApplicationRecord
    belongs_to :listing
    belongs_to :participant , class_name: 'User'
    has_many :conversation_messages, dependent: :delete_all
    has_one :last_message, -> { order(created_at: :desc) }, class_name: 'ConversationMessage'
end
