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
class Report < ApplicationRecord
end
