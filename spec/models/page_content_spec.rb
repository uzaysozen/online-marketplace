# == Schema Information
#
# Table name: page_contents
#
#  id         :bigint           not null, primary key
#  content    :text             default([]), is an Array
#  key        :string(50)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require 'rails_helper'

RSpec.describe PageContent, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
