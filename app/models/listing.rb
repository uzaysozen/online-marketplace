# == Schema Information
#
# Table name: listings
#
#  id                   :bigint           not null, primary key
#  description          :text
#  discounted_price     :decimal(, )
#  is_active            :boolean
#  is_moderated         :boolean
#  location             :string(50)
#  price                :decimal(, )
#  swap                 :boolean
#  title                :string(50)
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  creator_id           :bigint
#  delivery_id          :bigint
#  listing_category_id  :bigint
#  listing_condition_id :bigint
#  listing_status_id    :bigint
#  moderator_id         :bigint
#  receiver_id          :bigint
#
class Listing < ApplicationRecord
    belongs_to :creator, class_name: "User"
    belongs_to :moderator, class_name: "User"
    belongs_to :receiver, class_name: "User"
    belongs_to :listing_condition
    belongs_to :listing_status
    belongs_to :listing_category
    belongs_to :listing_delivery
    has_many :listing_images
    has_many :listing_views
    has_many :listing_questions
    has_many :listing_ratings
    has_many :user_favourites
    has_many :reports
    has_many :conversations
end
