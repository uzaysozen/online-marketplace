# == Schema Information
#
# Table name: conversation_messages
#
#  id              :bigint           not null, primary key
#  content         :text
#  is_deleted      :boolean          default(FALSE), not null
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
FactoryBot.define do
  factory :conversation_message do
    
  end
end
