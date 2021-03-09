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
class ConversationMessage < ApplicationRecord
end
