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
#  swap_listing_id :bigint
#
# Indexes
#
#  index_conversation_messages_on_conversation_id  (conversation_id)
#  index_conversation_messages_on_sender_id        (sender_id)
#  index_conversation_messages_on_swap_listing_id  (swap_listing_id)
#
# Foreign Keys
#
#  fk_rails_...  (conversation_id => conversations.id)
#  fk_rails_...  (sender_id => users.id)
#  fk_rails_...  (swap_listing_id => listings.id)
#
require 'rails_helper'

RSpec.describe ConversationMessage, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
