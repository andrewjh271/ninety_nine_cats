# == Schema Information
#
# Table name: sessions
#
#  id               :bigint           not null, primary key
#  session_token    :string           not null
#  user_id          :integer          not null
#  browser_name     :string
#  platform_name    :string
#  platform_version :string
#  created_at       :datetime         not null
#  updated_at       :datetime         not null
#
class Session < ApplicationRecord
  belongs_to :user

end

# browser = Browser.new(request.env['HTTP_USER_AGENT'], accept_language: "en-us")
# browser.name
# browser.platform.name
# browser.platform.version
#
