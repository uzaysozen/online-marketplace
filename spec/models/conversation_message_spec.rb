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
require 'rails_helper'

RSpec.describe ConversationMessage, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
