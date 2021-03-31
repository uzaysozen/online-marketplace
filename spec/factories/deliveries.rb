# == Schema Information
#
# Table name: deliveries
#
#  id         :bigint           not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
FactoryBot.define do
  factory :delivery do
    name { "MyString" }
  end
end
