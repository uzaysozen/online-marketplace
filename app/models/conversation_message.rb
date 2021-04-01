# == Schema Information
#
# Table name: conversation_messages
#
#  id              :bigint           not null, primary key
#  content         :text
#  is_deleted      :boolean
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  conversation_id :bigint
#  sender_id       :bigint
#
# Indexes
#
#  index_conversation_messages_on_conversation_id  (conversation_id)
#  index_conversation_messages_on_sender_id        (sender_id)
#
# Foreign Keys
#
#  fk_rails_...  (conversation_id => conversations.id)
#  fk_rails_...  (sender_id => users.id)
#
class ConversationMessage < ApplicationRecord
    belongs_to :conversation
    belongs_to :sender, class_name: "User"
    has_many :reports
end
