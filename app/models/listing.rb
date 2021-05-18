# == Schema Information
#
# Table name: listings
#
#  id                   :bigint           not null, primary key
#  description          :text
#  discounted_price     :decimal(, )
#  location             :string(50)
#  price                :decimal(, )
#  swap                 :boolean
#  title                :string(50)
#  created_at           :datetime         not null
#  updated_at           :datetime         not null
#  creator_id           :bigint
#  listing_category_id  :bigint
#  listing_condition_id :bigint
#  listing_status_id    :bigint
#  receiver_id          :bigint
#
# Indexes
#
#  index_listings_on_creator_id            (creator_id)
#  index_listings_on_listing_category_id   (listing_category_id)
#  index_listings_on_listing_condition_id  (listing_condition_id)
#  index_listings_on_listing_status_id     (listing_status_id)
#  index_listings_on_receiver_id           (receiver_id)
#
# Foreign Keys
#
#  fk_rails_...  (creator_id => users.id)
#  fk_rails_...  (listing_category_id => listing_categories.id)
#  fk_rails_...  (listing_condition_id => listing_conditions.id)
#  fk_rails_...  (listing_status_id => listing_statuses.id)
#  fk_rails_...  (receiver_id => users.id)
#
class Listing < ApplicationRecord
    belongs_to :creator, class_name: "User"
    belongs_to :moderator, class_name: "User"
    belongs_to :receiver, class_name: "User"
    belongs_to :listing_condition
    belongs_to :listing_status
    belongs_to :listing_category

    has_many :listing_views, dependent: :destroy
    has_many :listing_questions, dependent: :destroy
    has_one :listing_rating, dependent: :destroy
    has_many :reports
    has_many :conversations, dependent: :destroy
    has_many_attached :images

    has_many :listing_deliveries, dependent: :destroy
    has_many :deliveries, through: :listing_deliveries

    has_many :user_favourites, dependent: :destroy
    has_many :followers, class_name: "User", through: :user_favourites

    has_many :listing_tags, dependent: :destroy
    has_many :tags, through: :listing_tags

    def delivery_ids
        delivery_objs = self.deliveries
        return delivery_objs.ids
    end
    
    validates :deliveries, presence: true
    validates :description, presence: true
    validates :images, presence: true
    validates :location, presence: true
    validates :title, presence: true  
end
