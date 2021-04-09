# == Schema Information
#
# Table name: deliveries
#
#  id         :bigint           not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require 'rails_helper'

RSpec.describe Delivery, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
