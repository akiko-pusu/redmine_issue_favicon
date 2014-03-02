class IssueFaviconUserSetting < ActiveRecord::Base
  unloadable
  belongs_to :user
  validates_presence_of :user

  def self.find_or_create_by_user_id(user_id)
    issue_favicon = IssueFaviconUserSetting.where(:user_id => user_id).first
    unless issue_favicon
      issue_favicon = IssueFaviconUserSetting.new
      issue_favicon.user_id = user_id
    end
    issue_favicon
  end

  def self.destroy_by_user_id(user_id)
    issue_favicon = IssueFaviconUserSetting.where(:user_id => user_id).first
    issue_favicon.destroy if issue_favicon
  end

  def enabled?
    self.enabled == true
  end
end
