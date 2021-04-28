# == Schema Information
#
# Table name: page_contents
#
#  id         :bigint           not null, primary key
#  content    :text
#  key        :string(50)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
FactoryBot.define do
  factory :page_content do
    key { "MyString" }
    content { "MyText" }
  end
end
