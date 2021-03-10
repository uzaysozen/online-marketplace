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
class PageContent < ApplicationRecord
end
