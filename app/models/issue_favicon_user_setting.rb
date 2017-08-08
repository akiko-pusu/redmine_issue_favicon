class IssueFaviconUserSetting < ActiveRecord::Base
  belongs_to :user
  validates_presence_of :user

  # User preference to overwride global setting and to turn on / off.
  enum favicon: { show: 'show', hide: 'hide', default: 'default' }

  def self.find_or_create_by_user_id(user_id)
    issue_favicon = IssueFaviconUserSetting.where(user_id: user_id).first
    unless issue_favicon
      issue_favicon = IssueFaviconUserSetting.new(favicon: :default)
      issue_favicon.user_id = user_id
    end
    issue_favicon
  end

  def self.destroy_by_user_id(user_id)
    issue_favicon = IssueFaviconUserSetting.where(user_id: user_id).first
    issue_favicon.destroy if issue_favicon
  end

  def self.i18n_favicons(hash = {})
    favicons.keys.each { |key| hash[I18n.t("label_#{key}", default: key)] = key }
    hash
  end
end
