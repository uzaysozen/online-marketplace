# == Schema Information
#
# Table name: users
#
#  id                 :bigint           not null, primary key
#  current_sign_in_at :datetime
#  current_sign_in_ip :inet
#  dn                 :string
#  email              :string           default(""), not null
#  givenname          :string
#  last_sign_in_at    :datetime
#  last_sign_in_ip    :inet
#  mail               :string
#  ou                 :string
#  sign_in_count      :integer          default(0), not null
#  sn                 :string
#  uid                :string
#  username           :string
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
  has_many :user_favourites
  has_many :user_listings, foreign_key: "creator_id", class_name: "Listing"
  has_many :receiver_listings, foreign_key: "receiver_id", class_name: "Listing"
  has_many :moderator_listings, foreign_key: "moderator_id", class_name: "Listing"
  has_many :listing_views
  has_many :conversations, foreign_key: "participant_id"
  has_many :conversation_messages, foreign_key: "sender_id"
  end
