# == Schema Information
#
# Table name: user_favourites
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  listing_id :bigint
#  user_id    :bigint
#
require 'rails_helper'

RSpec.describe UserFavourite, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
