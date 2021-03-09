# == Schema Information
#
# Table name: listing_categories
#
#  id         :bigint           not null, primary key
#  name       :string(50)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  parent_id  :bigint
#
class ListingCategory < ApplicationRecord
    has_many :children, :class_name => "ListingCategory", foreign_key: 'parent_id'
    belongs_to :parent, :class_name => "ListingCategory", foreign_key: 'parent_id', :optional => true
end
