# == Schema Information
#
# Table name: listing_categories
#
#  id                 :bigint           not null, primary key
#  name               :string(50)
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  parent_category_id :bigint
#
# Indexes
#
#  index_listing_categories_on_parent_category_id  (parent_category_id)
#
# Foreign Keys
#
#  fk_rails_...  (parent_category_id => listing_categories.id)
#
class ListingCategory < ApplicationRecord
    has_many :subcategories, :class_name => "ListingCategory", foreign_key: :parent_category_id
    belongs_to :parent_category, :class_name => "ListingCategory", foreign_key: :parent_category_id, :optional => true
    has_many :listings
end
