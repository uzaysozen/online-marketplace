# == Schema Information
#
# Table name: notifications
#
#  id         :bigint           not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
FactoryBot.define do
  factory :notification do
    name { "MyString" }
  end
end
