# == Schema Information
#
# Table name: categories
#
#  id         :bigint           not null, primary key
#  name       :string(50)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  parent_id  :bigint
#
FactoryBot.define do
  factory :category do
    
  end
end
