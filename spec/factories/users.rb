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
FactoryBot.define do
  factory :user, aliases: [:creator, :moderator, :receiver, :participant] do
    
  end
end
