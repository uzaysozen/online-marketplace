# == Schema Information
#
# Table name: users
#
#  id                 :bigint           not null, primary key
#  administrator      :boolean
#  ban_reason         :text
#  current_sign_in_at :datetime
#  current_sign_in_ip :inet
#  dn                 :string
#  email              :string           default(""), not null
#  email_category     :boolean
#  email_message      :boolean
#  givenname          :string
#  is_banned          :boolean          default(FALSE)
#  last_sign_in_at    :datetime
#  last_sign_in_ip    :inet
#  mail               :string
#  ou                 :string
#  rating             :float
#  rating_count       :bigint
#  sign_in_count      :integer          default(0), not null
#  sn                 :string
#  uid                :string
#  user_categories    :text             default([]), is an Array
#  username           :string
#  when               :text
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#
# Indexes
#
#  index_users_on_email     (email)
#  index_users_on_username  (username)
#
class User < ApplicationRecord
  include EpiCas::DeviseHelper
  
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_many :reports
  has_many :user_listings, foreign_key: "creator_id", class_name: "Listing"
  has_many :receiver_listings, foreign_key: "receiver_id", class_name: "Listing"
  has_many :moderator_listings, foreign_key: "moderator_id", class_name: "Listing"
  has_many :listing_views
  has_many :conversations, foreign_key: "participant_id"
  has_many :received_conversations, source: :conversations, through: :user_listings
  has_many :conversation_messages, foreign_key: "sender_id"

  has_many :user_favourites
  has_many :favourites, source: :listing, through: :user_favourites

  def active_for_authentication?
    super && !is_banned
  end
end
