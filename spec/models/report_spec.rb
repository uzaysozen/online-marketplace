# == Schema Information
#
# Table name: reports
#
#  id           :bigint           not null, primary key
#  message      :text
#  outcome      :text
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  listing_id   :bigint
#  message_id   :bigint
#  moderator_id :bigint
#  user_id      :bigint
#
require 'rails_helper'

RSpec.describe Report, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
