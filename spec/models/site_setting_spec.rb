# == Schema Information
#
# Table name: site_settings
#
#  id            :bigint           not null, primary key
#  blocked_words :text
#  key           :string(50)
#  value         :string
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
require 'rails_helper'

RSpec.describe SiteSetting, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
