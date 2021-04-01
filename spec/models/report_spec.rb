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
#  reporter_id             :bigint
#
# Indexes
#
#  index_reports_on_conversation_message_id  (conversation_message_id)
#  index_reports_on_listing_id               (listing_id)
#  index_reports_on_moderator_id             (moderator_id)
#  index_reports_on_reporter_id              (reporter_id)
#
# Foreign Keys
#
#  fk_rails_...  (conversation_message_id => conversation_messages.id)
#  fk_rails_...  (listing_id => listings.id)
#  fk_rails_...  (moderator_id => users.id)
#  fk_rails_...  (reporter_id => users.id)
#
require 'rails_helper'

RSpec.describe Report, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
