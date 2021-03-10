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
FactoryBot.define do
  factory :site_setting do
    key { "MyString" }
    value { "MyString" }
    blocked_words { "MyText" }
  end
end
