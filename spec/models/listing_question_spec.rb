# == Schema Information
#
# Table name: listing_questions
#
#  id         :bigint           not null, primary key
#  answer     :string(50)
#  question   :string(50)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  listing_id :bigint
#
require 'rails_helper'

RSpec.describe ListingQuestion, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
